require 'Classes.rb'
require 'lib.rb'

def generate_predefined_questions
	Question.create_text_question("pkg_name","Package Name")
	Question.create_text_question("src_path","Source File")
	Question.create_text_question("patch_path","Patch File")
	Question.create_text_question("version","Version")
	Question.create_text_question("release","Release")
	Question.create_multiple_choice("license","License",["GPL","LGPL","Library GPL","BSD","MIT","Other"],[90,30,20,30,10])
	Question.create_text_question("group","Group")
	Question.create_text_question("buildroot","Build Root")
	Question.create_text_question("configure_args","Configure arguments")
	Question.create_text_question("cflags","CFLAGS")
	Question.create_text_question("cxxflags","CXXFLAGS")
	Question.create_text_question("distro","Distribution")
	Question.create_text_question("maintainer","Maintainer")
	Question.create_text_question("depends","Depends")
	Question.create_multiple_choice("arch","Architecture",["i386","i686","ppc"])
	Question.create_text_question("vendor","Vendor")
	Question.create_text_question("packager_name","Packager Name")
	Question.create_text_question("packager_email","Packager Email")
	Question.create_text_question("changes","Changes")
	Question.create_text_question("section","Section")
	Question.create_text_question("summary","Summary")
	Question.create_text_question("description","Description")
end
