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

#!/usr/bin/env ruby

require 'rubygems'
require 'xml/libxml'

################################
#RPM Creation function starts  #
################################

def create_rpm_control_files(xmldesc,args)

root = xmldesc.root
header = root.find_first('Header')
prep = root.find_first('Prep')
build = root.find_first('Build')
install = root.find_first('Install')
files = root.find_first('Files')
post = root.find_first('Post')
clean = root.find_first('Clean')
version = header.find_first('Package/Version')

specfile = File.new(args.split(".")[0].concat(".spec"),"w")

specfile.print("Name:\t#{header.find_first('Package')['Name']}\n")
specfile.print("Version:\t#{version['value']}\n")
specfile.print("Release:\t#{version.find_first('Release').content}\n")
specfile.print("License:\t#{header.find_first('License').content}\n")
specfile.print("Group:\t#{version.find_first('Group').content}\n")
specfile.print("Summary:\t#{header.find_first('Summary').content}\n")
count=0
header.find('Sources/Source').each do |source|
	specfile.print("Source#{count}:\t#{source.content}\n")
	count = count+1
end
count=0
version.find('Patches/Patch').each do |patch|
	specfile.print("Patch#{count}:\t#{patch.content}\n")
        count = count+1
end

specfile.print("BuildRoot:\t#{version.find_first('BuildRoot').content}\n")
specfile.print("%description\n")
specfile.print("#{header.find_first('Description').content}\n")

if header.find_first('Description')['case'] == "Suse"
	specfile.print("#{header.find_first('Authors')}\n")
end

specfile.print("\n%prep\n")
specfile.print("cd %{_topdir}/BUILD\n")
specfile.print("rm -rf %{name}-%{version}-build\n")
specfile.print("tar -xjf %{_topdir}/SOURCES/\n")

specfile.print("\n%build\n")
specfile.print("cd %{name}-%{version}-build\n")

count=0
build.find('configure-flags').each do |cflag|
	if count==0
		specfile.print("./configure ")
	end
	specfile.print("--#{cflag.content}")
end

build.find('make-target').each do |mtarget|
	specfile.print("\nmake #{mtarget.content}\n")
end

specfile.print("\n%install\n")
specfile.print("cd %{name}-%{version}-build\n")

specfile.print("make ")

install.find('destdir').each do |dest|
	specfile.print("DESTDIR=#{dest.content}")
end

install.find('install-target').each do |inst|
        specfile.print("#{inst.content}\n")
end

specfile.print("\n%post\n")

post.find('Post-calls').each do |postcalls|
	specfile.print("#{postcalls.content}\n")
end

specfile.print("\n%clean\n")

clean.find('Clean-calls').each do |cleancalls|
	specfile.print("#{cleancalls.content}\n")
end

specfile.print("\n%files\n")

if files.find_first('defattr')
	specfile.print("%defattr#{files.find_first('defattr').content}\n")
else
	specfile.print("%defattr(-,root,root)\n")
end

files.find('dir').each do |dir|
        specfile.print("%dir #{dir.content}\n")
end

files.find('files').each do |files|
	specfile.print("#{files.content}\n")
end

files.find('docs').each do |doc|
	specfile.print("%doc #{doc.content}\n")
end

specfile.print("\n%changelog\n")

root.find('Changelog').each do |changelog|
	specfile.print("* #{changelog.find_first('Date').content} #{changelog.find_first('Name').content} <#{changelog.find_first('email')}>\n- #{changelog.find_first('Changes')}\n")
end

end
#############################
#RPM Creation function ends #
#############################


###############################
#Deb Creation function begins #
###############################

def create_deb_control_files(xmldesc,args)

root = xmldesc.root
header = root.find_first('Header')
version = header.find_first('Package/Version')

controlfile = File.new("control","w")

controlfile.print("Package: #{header.find_first('Package')['Name']}\n")
controlfile.print("Version: #{version['value']}-#{version.find_first('Release').content}\n")

if version.find('Section')
	controlfile.print("Section: #{version.find_first('Section').content}\n")
end

if version.find('Priority')
	controlfile.print("Priority: #{version.find_first('Priority').content}\n")
end
controlfile.print("Architecture: #{version.find_first('Architecture').content}\n")

if version.find_first('Depends')
	controlfile.print("Depends: #{version.find_first('Depends').content}\n")
end

if version.find_first('Recommends')
	controlfile.print("Recommends: #{version.find_first('Recommends')}\n")
end

if version.find_first('Suggests')
        controlfile.print("Suggests: #{version.find_first('Suggests').content}\n")
end

controlfile.print("Maintainer: #{header.find_first('Maintainer').content}\n")

controlfile.print("Description: #{header.find_first('Description').content}\n")

end

#############################
#Deb Creation function ends #
#############################


args=$*
args.each do |args|
	xmldesc = XML::Document.file(args)
	xsd = XML::Schema.new('genspec.xsd')
#	doc.validate_schema(xsd)
	create_rpm_control_files(xmldesc,args)
	create_deb_control_files(xmldesc,args)
end