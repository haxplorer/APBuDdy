require 'Classes.rb'

def generate_predefined_questions
	Question.create_text_question("pkg_name","Package Name")
	Question.create_text_question("src_path","Source File")
	Question.create_text_question("version","Version")
	Question.create_text_question("release","Release")
	Question.create_multiple_choice("license","License",["GPL","LGPL","Library GPL","BSD","MIT","Other"],[90,30,20,30,10])
	Question.create_text_question("group","Group")
	Question.create_text_question("buildroot","Build Root")
	Question.create_text_question("configure_args","Configure arguments")
	Question.create_text_question("distro","Distribution")
	Question.create_text_question("maintainer","Maintainer")
	Question.create_text_question("depends","Depends")
	Question.create_multiple_choice("arch","Architecture",["i386","i686","ppc"])
	Question.create_text_question("vendor","Vendor")
	Question.create_text_question("changelog","Changelog")
	Question.create_text_question("section","Section")
end


