require 'rubygems'
require 'xml/libxml'
require 'Classes.rb'
require 'open-uri'

def dummy
	return Guess.new("",0)
end

def parse_distro_name_from_release(filename)
	return File.new(filename,"r").gets.split(" ")[0]
end

def get_homedir
	return `echo $HOME`.chomp
end

def get_packager_name
	return Guess.new(`whoami`.chomp,30)
end

def get_changes
	if File.exist?("#{Sysvars.get_extracted_dir}/CHANGES")
		return Guess.new(File.new("#{Sysvars.get_extracted_dir}/CHANGES").read,30)
	else
		return Guess.new("",0)
	end
end

def find_distro()

if FileTest.exist?("/usr/bin/lsb_release")

	system("lsb_release -a | grep -i \"Distributor ID:\" | awk -F \":\" '{ print $2 }' | awk '{ print $1 }'>lsb_release_output")
	distro_name = File.new("lsb_release_output","r").gets
	system("rm lsb_release_output")
	return Guess.new(distro_name,60)

elsif FileTest.exist?("/etc/redhat-release")

	return Guess.new(parse_distro_name_from_release("/etc/redhat-release"),90)

elsif FileTest.exist?("/etc/mandrake-release")

	return Guess.new(parse_distro_name_from_release("/etc/mandrake-release"),90)

elsif FileTest.exist?("/etc/issue.net")

	return Guess.new(parse_distro_name_from_release("/etc/issue.net"),60)

elsif FileTest.exist?("/etc/gentoo-release")

	return Guess.new(parse_distro_name_from_release("/etc/gentoo-release"),90)

elsif FileTest.exist?("/etc/slackware-version")

	return Guess.new(parse_distro_name_from_release("/etc/slackware-version"),90)

elsif FileTest.exist?("/sbin/SuSEconfig")

	return Guess.new("SuSE",90)

else
        
	return Guess.new("Unknown",0)

end

end


def get_arch()

	return Guess.new(`uname -m`.chomp,90)

end


def get_package_name()
	if Pkgvars.get_pkg_name.size!=0
	return Pkgvars.get_pkg_name
	else
	return File.basename(Pkgvars.get_src_path).split("-")[0]
	end
end


def get_version

	package_path = Pkgvars.get_src_path
	version = ""
	Pkgvars.get_src_path.split("/")[Pkgvars.get_src_path.split("/").size-1].split("-").each do |part|
	if part.to_f!=0.0
		version = part.split(".")[0].concat(".").concat(part.split(".")[1])
	end
	end
	return Guess.new(version,60)

end

def download_file(url,destdir=".")
	downloaded_file = File.new("#{destdir}/#{File.basename(url)}","w")
	downloaded_file.print(open(url).read)
end


def find_license_type

puts Sysvars.get_extracted_dir

if FileTest.exist?("#{Sysvars.get_extracted_dir}/COPYING")
	license_file = File.new("#{Sysvars.get_extracted_dir}/COPYING")
elsif FileTest.exist?("#{Sysvars.get_extracted_dir}/copying")
        license_file = File.new("#{Sysvars.get_extracted_dir}/copying")
elsif FileTest.exist?("#{Sysvars.get_extracted_dir}/LICENSE")
        license_file = File.new("#{Sysvars.get_extracted_dir}/LICENSE")
elsif FileTest.exist?("#{Sysvars.get_extracted_dir}/MIT-LICENSE")
	return Guess.new("MIT",90)
else
	return Guess.new("Other",30)
end

license_content = license_file.read

if (license_content =~ /GNU LESSER GENERAL PUBLIC LICENSE/)
	return Guess.new("LGPL",90)
elsif (license_content =~ /GNU LIBRARY GENERAL PUBLIC LICENSE/)
	return Guess.new("Library GPL",90)
elsif (license_content =~ /GNU GENERAL PUBLIC LICENSE/)
	return Guess.new("GPL",90)
elsif (license_content =~ /BSD/)
	return Guess.new("BSD",90)
end

end


def get_sourcedir()
	if (FileTest.exist?("$HOME/.apbd") && FileTest.directory?("$HOME/.apbd"))
		if FileTest.exist?("$HOME/.apbd/SOURCES")
			return "$HOME/.apbd/SOURCES"
		else
			system("mkdir $HOME/.apbd/SOURCES")
		end
	elsif FileTest.exist?("$HOME/.apbd") && !FileTest.directory?("$HOME/.apbd")
		system("rm $HOME/.apbd")
		system("mkdir $HOME/.apbd $HOME/.apbd/SOURCES")
		return "$HOME/.apbd/SOURCES"
	else
		system("mkdir $HOME/.apbd $HOME/.apbd/SOURCES")
		return "$HOME/.apbd/SOURCES"
	end
end

def unpack(filename)
	name = File.basename(filename)
	type = name.split(".")[name.split(".").size-1]
	if type=="gz"
		arg = "z"
	elsif type=="bz2"
		arg="j"
	end
	sourcedir = get_sourcedir()
	system("tar -t#{arg}f #{filename} >/tmp/#{name}.qst")
	system("awk -F \"/\" '{print $1}' /tmp/#{name}.qst | uniq | wc -l >/tmp/#{name}_no_of_folders_in_tar")
	if File.new("/tmp/#{name}_no_of_folders_in_tar","r").gets.to_i>1
		system("rm /tmp/#{name}_no_of_folders_in_tar")
		system("mkdir #{name.split(".")[0]}; cd #{name.split(".")[0]}")
	end
	system("cd #{sourcedir};tar -x#{arg}vf #{filename} >/tmp/#{name}.qsx")
	Sysvars.set_extracted_dir(`cat /tmp/#{File.basename(Pkgvars.get_src_path)}.qst | awk -F '/' '{print $1}' | uniq`.chomp)
end

def file_get_unpack
		package_path = "#{get_homedir()}/.apbd/PACKAGES/#{File.basename(Pkgvars.get_src_path)}"
                if FileTest.exist?(Pkgvars.get_src_path)
			system("cp #{Pkgvars.get_src_path} #{get_homedir()}/.apbd/PACKAGES/")
                        unpack(Pkgvars.get_src_path)
                elsif Pkgvars.get_src_path.split("://")[0]=="http" || Pkgvars.get_src_path.split("://")[0]=="ftp"
			download_file(Pkgvars.get_src_path,"#{get_homedir()}/.apbd/PACKAGES")
                        unpack(package_path)
                else
                        return 0
                end
end

def xml_writeout
	doc = XML::Document.new()
	doc.root = XML::Node.new('CommonDescription')
	root = doc.root
	root << header = XML::Node.new('Header')
	header << package = XML::Node.new('Package')
	package['Name'] = get_package_name
	package << version = XML::Node.new('Version')
	version['value'] = Pkgvars.get_version
	version << release = XML::Node.new('Release')
	release << Pkgvars.get_release
	version << group = XML::Node.new('Group')
	group << Pkgvars.get_group
	version << priority = XML::Node.new('Priority')
	version << arch = XML::Node.new('Architecture')
	arch << Pkgvars.get_arch
	version << depends = XML::Node.new('Depends')
	version << suggests = XML::Node.new('Suggests')
	version << conflicts = XML::Node.new('Conflicts')
	version << buildroot = XML::Node.new('BuildRoot')
	buildroot << Pkgvars.get_buildroot
	version << patches = XML::Node.new('Patches')
	version << vendor = XML::Node.new('Vendor')
	version << splitrule = XML::Node.new('Splitrule')
	version << section = XML::Node.new('Section')
	section << Pkgvars.get_section
	header << sources = XML::Node.new('Sources')
	sources << source = XML::Node.new('Source')
	source << Pkgvars.get_src_path
	header << maintainer = XML::Node.new('Maintainer')
	maintainer << Pkgvars.get_maintainer
	header << license = XML::Node.new('License')
	license << Pkgvars.get_license
	header << summary = XML::Node.new('Summary')
	summary << Pkgvars.get_summary
	header << description = XML::Node.new('Description')
	description << Pkgvars.get_description
	
	root << prep = XML::Node.new('Prep')
	prep << setup = XML::Node.new('Setup')
	prep << patch = XML::Node.new('Patch')
	
	root << build = XML::Node.new('Build')
	build << configure_flags = XML::Node.new('configure-flags')
	configure_flags << Pkgvars.get_extra_configure_args

	root << install = XML::Node.new('Install')
	install << install_target = XML::Node.new('install-target')
	
	root << post = XML::Node.new('Post')
	post << post_calls = XML::Node.new('Post-calls')
	
	root << clean = XML::Node.new('Clean')

	root << files = XML::Node.new('Files')
	list_files = Dir.glob("/tmp/tmproot/**/*")
	list_files.each do |file|
	files << sub_files = XML::Node.new("files")
	sub_files << file.split("/tmp/tmproot")[1]
	end

	root << changelog = XML::Node.new('Changelog')
	changelog << date = XML::Node.new('Date')
	date << Time.now.strftime("%a %b %d %Y")
	changelog << name = XML::Node.new('Name')
	name << Pkgvars.get_packager_name
	changelog << email = XML::Node.new('email')
	email << Pkgvars.get_packager_email
	changelog << changes = XML::Node.new('Changes')
	changes << Pkgvars.get_changes
	
	format = true
	doc.save("#{get_homedir}/.apbd/#{get_package_name}.xml", format)
end
