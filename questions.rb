require 'Classes.rb'
require 'lib.rb'

def generate_predefined_questions
	Question.create_text_question("pkg_name","Package Name")
	Question.create_text_question("src_path","Source File")
	Question.create_text_question("patch_path","Patch File")
	Question.create_text_question("version","Version")
	Question.create_text_question("release","Release")
	Question.create_multiple_choice("license","License",["GPL","LGPL","Library GPL","BSD","MIT","Other"])
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
	Question.create_text_question("scriptlet","Scriptlet XML File")
end

        $hash_guess = Hash.new()
        $hash_guess["pkg_name"] = proc{dummy}
        $hash_guess["src_path"] = proc{dummy}
        $hash_guess["patch_path"] = proc{dummy}
        $hash_guess["version"] = proc{get_version}
        $hash_guess["release"] = proc{get_release}
        $hash_guess["license"] = proc{find_license_type}
        $hash_guess["group"] = proc{guess_group}
        $hash_guess["buildroot"] = proc{dummy}
        $hash_guess["configure_args"] = proc{dummy}
        $hash_guess["cflags"] = proc{guess_cflags}
        $hash_guess["cxxflags"] = proc{guess_cflags}
        $hash_guess["distro"] = proc{find_distro}
        $hash_guess["maintainer"] = proc{get_packager_name}
        $hash_guess["depends"] = proc{dummy}
        $hash_guess["arch"] = proc{get_arch}
        $hash_guess["vendor"] = proc{dummy}
        $hash_guess["packager_name"] = proc{get_packager_name}
        $hash_guess["packager_email"] = proc{dummy}
        $hash_guess["changes"] = proc{get_changes}
        $hash_guess["section"] = proc{guess_section}
        $hash_guess["summary"] = proc{dummy}
        $hash_guess["description"] = proc{dummy}
	$hash_guess["scriptlet"] = proc{dummy}

