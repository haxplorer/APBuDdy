############################################################################
#    Copyright (C) 2006 by Rajagopal N   #
#    rajagopal.developer@gmail.com   #
#                                                                          #
#    This program is free software; you can redistribute it and#or modify  #
#    it under the terms of the GNU General Public License as published by  #
#    the Free Software Foundation; either version 2 of the License, or     #
#    (at your option) any later version.                                   #
#                                                                          #
#    This program is distributed in the hope that it will be useful,       #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#    GNU General Public License for more details.                          #
#                                                                          #
#    You should have received a copy of the GNU General Public License     #
#    along with this program; if not, write to the                         #
#    Free Software Foundation, Inc.,                                       #
#    59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
############################################################################


def parse_distro_name_from_release(filename)

	return File.new(filename,"r").gets.split(" ")[0]

end

def get_homedir()
	return `echo $HOME`.chomp
end

def find_distro()

if FileTest.exist?("/usr/bin/lsb_release")

	system("lsb_release -a | grep -i \"Distributor ID:\" | awk -F \":\" '{ print $2 }' | awk '{ print $1 }'>lsb_release_output")
	distro_name = File.new("lsb_release_output","r").gets
	system("rm lsb_release_output")
	return distro_name

elsif FileTest.exist?("/etc/redhat-release")

	return parse_distro_name_from_release("/etc/redhat-release")

elsif FileTest.exist?("/etc/mandrake-release")

	return parse_distro_name_from_release("/etc/mandrake-release")

elsif FileTest.exist?("/etc/issue.net")

	return parse_distro_name_from_release("/etc/issue.net")

elsif FileTest.exist?("/etc/gentoo-release")

	return parse_distro_name_from_release("/etc/gentoo-release")

elsif FileTest.exist?("/etc/slackware-version")

	return parse_distro_name_from_release("/etc/slackware-version")

elsif FileTest.exist?("/sbin/SuSEconfig")

	return "SuSE"

else
        
	return "Unknown"

end

end


def get_arch()

	system("uname -m >uname_output")
	arch = File.new("uname_output","r").gets
	system("rm uname_output")
	return arch

end


def get_package_name(package_path)

	return package_path.split("/")[package_path.split("/").size-1].split("-")[0]

end


def get_version(package_path)

	version = ""
	package_path.split("/")[package_path.split("/").size-1].split("-").each do |part|
	if part.to_f!=0.0
		version = part.split(".")[0].concat(".").concat(part.split(".")[1])
	end
	end
	return version

end


def find_license_type(sourcedir)

if FileTest.exist?("#{sourcedir}/COPYING")
	license_file = File.new("#{sourcedir}/COPYING")
elsif FileTest.exist?("#{sourcedir}/copying")
        license_file = File.new("#{sourcedir}/copying")
elsif FileTest.exist?("#{sourcedir}/LICENSE")
        license_file = File.new("#{sourcedir}/LICENSE")
elsif FileTest.exist?("#{sourcedir}/MIT-LICENSE")
	return "MIT"
else
	return "Enter Manually!!"
end

license_content = File.read(license_file)

if (license_content =~ /GNU LESSER GENERAL PUBLIC LICENSE/)
	return "LGPL"
elsif (license_content =~ /GNU LIBRARY GENERAL PUBLIC LICENSE/)
	return "Library GPL"
elsif (license_content =~ /GNU GENERAL PUBLIC LICENSE/)
	return "GPL"
elsif (license_content =~ /BSD/)
	return "BSD"
end

end


def get_sourcedir()
	if (FileTest.exist?("$HOME/.quickspec") && FileTest.directory?("$HOME/.quickspec"))
		if FileTest.exist?("$HOME/.quickspec/SOURCES")
			return "$HOME/.quickspec/SOURCES"
		else
			system("mkdir $HOME/.quickspec/SOURCES")
		end
	elsif FileTest.exist?("$HOME/.quickspec") && !FileTest.directory?("$HOME/.quickspec")
		system("rm $HOME/.quickspec")
		system("mkdir $HOME/.quickspec $HOME/.quickspec/SOURCES")
		return "$HOME/.quickspec/SOURCES"
	else
		system("mkdir $HOME/.quickspec $HOME/.quickspec/SOURCES")
		return "$HOME/.quickspec/SOURCES"
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
end


def get_question_byname(name)
	Question.get_question_queue.each do |question_item|
		if question_item.get_name==name
			return question_item
		end
	end
	return nil
end
