#!/usr/bin/env ruby

require 'lib.rb'

        $hash_guess = Hash.new()
        $hash_guess["pkg_name"] = proc{dummy}
        $hash_guess["src_path"] = proc{dummy}
	$hash_guess["patch_path"] = proc{dummy}
        $hash_guess["version"] = proc{get_version}
        $hash_guess["release"] = proc{dummy}
        $hash_guess["license"] = proc{find_license_type}
        $hash_guess["group"] = proc{dummy}
        $hash_guess["buildroot"] = proc{dummy}
        $hash_guess["configure_args"] = proc{dummy}
	$hash_guess["cflags"] = proc{dummy}
	$hash_guess["cxxflags"] = proc{dummy}
        $hash_guess["distro"] = proc{find_distro}
        $hash_guess["maintainer"] = proc{dummy}
        $hash_guess["depends"] = proc{dummy}
        $hash_guess["arch"] = proc{get_arch}
        $hash_guess["vendor"] = proc{dummy}
        $hash_guess["packager_name"] = proc{get_packager_name}
        $hash_guess["packager_email"] = proc{dummy}
        $hash_guess["changes"] = proc{get_changes}
        $hash_guess["section"] = proc{dummy}
        $hash_guess["summary"] = proc{dummy}
        $hash_guess["description"] = proc{dummy}




#A class to represent each of the different phases in the program
class Guess
        def initialize(answer,credit)
                @answer = answer
                @credit = credit
        end
        def get_answer
                return @answer
        end
        def get_credit
                return @credit
        end
end

class Phase

	@@phase_queue = Array.new

	def initialize(name,steps,enabled=1)
		@name=name
		@steps=steps
		@enabled=enabled
	end
#	def Phase.phase_empty(name)
#		@name=name
#	end
	def Phase.phase_new_after(name,steps,name_prev,enabled=0)
                temp_phase=new(name,steps,enabled)
		puts @@phase_queue.size
                @@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.get_name==name_prev
                                @@phase_queue.insert(index+1,temp_phase)
				return
                        end
                end
	end
        def Phase.phase_new_before(name,steps,name_next,enabled=0)
                temp_phase=new(name,steps,enabled)
                pos=0
                @@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.get_name==name_next
                              pos=index  
                        end
                end
                @@phase_queue.insert(pos,temp_phase)
	end
	def Phase.run_phase_queue
                @@phase_queue.each do |phase_item|
		if phase_item.get_status==1
                        puts phase_item.get_steps
                        system("cd #{Sysvars.get_extracted_dir};#{phase_item.get_steps}")
			phase_item.disable
		end
                end
		
	end
	def Phase.phase_queue_concat(ext_queue)
		@@phase_queue.concat(ext_queue)
	end
	def Phase.get_phase_queue()
		return @@phase_queue
	end
	def Phase.phase_push(phase)
		@@phase_queue.push(phase)
	end
	def Phase.phase_addto_front(phase)
		@@phase_queue.insert(0,phase)
	end
	def enable
		@enabled=1
	end
	def disable
		@enabled=0
	end
	def get_steps()
		return @steps
	end
	def get_status
		return @enabled
	end
	def get_name
		return @name
	end
	def move_to_before(name_next)
                temp_phase=self
                @@phase_queue.delete_if{|item| item.name==self.name}
		@@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.name==name_next
                              pos=index-1
                        end
                end
		@@phase_queue.insert(pos,temp_phase)
	end
	def move_to_after(name_prev)
                temp_phase=self
                @@phase_queue.delete_if{|item| item.name==self.name}
                @@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.name==name_prev
                                @@phase_queue.insert(index,temp_phase)
                        end
                end
	end
end


#A class to represent each of the responses for any question
class Option
	def initialize(option_string,credit=0)
		@response = option_string
		@credit = credit
	end
	def get_response
		return @response
	end
	def add_credit(new_credit)
		@credit+=new_credit
	end
end


#A Class to represent something like if optionX for questionA is true, optionY for questionB should gain N credits
#Currently not being used!!
class Association
	def initialize(local_response,remote_question,remote_response,credit_modifier)
		@local_response = local_response
		@remote_question = remote_question
		@remote_response = remote_response
		@credit_modifier = credit_modifier
	end
end


#Question class with a query string which will be displayed as the question at the prompt and an optionset which will be the choice of answers
#The name field is to be used as an id and it is suggested to use the required variable's name as the name
class Question

	@@question_queue = Array.new
	@@asked_list = Array.new
	@@credit_threshold = 0
	#use this to create an objective question
	def initialize(name,query_string,options,credits=[])
		@name = name
		@query_string = query_string
		@optionset = Array.new
		options.each_with_index do |option_item,i|
			if options.size==credits.size
				@optionset.push(Option.new(option_item,credits.at(i)))
			else
				@optionset.push(Option.new(option_item))
			end
		end
		@choice_selected = ""
		@status = "created"
		@hide = 0
		@@question_queue.push(self)
	end
	#A wrapper to have uniform constructor names
	def Question.create_multiple_choice(name,query_string,options,credits=[])
		new(name,query_string,options,credits)
	end
	#use this to create an yes/no type question
	def Question.create_yes_no(name,query_string)
		options=["yes","no"]
		new(name,query_string,options)
	end
	def Question.create_text_question(name,query_string)
		options = []
		new(name,query_string,options)
	end
	def Question.get_question_queue
		return @@question_queue
	end
	def Question.get_question_byname(name)
		@@question_queue.each do |question_item|
			if question_item.get_name==name
				return question_item
			end
		end
		return nil
	end
	def Question.get_asked_list
		return @@asked_list
	end
	def Question.commit_all_asked
		@@asked_list.each do |asked_item|
			Question.get_question_byname(asked_item.get_name).commit(asked_item.get_answer)
			Pkgvars.set_var(asked_item.get_name,asked_item.get_answer)
		end
	end
	def Question.clear_asked_list
		@@asked_list.clear
	end
        def Question.set_expertise(expertise)
                case expertise
                when "Newbie"
                @@credit_threshold = 30
                when "Average"
                @@credit_threshold = 60
                when "Good"
                @@credit_threshold = 100
		end
        end

	def modify_credit(option_string,new_credit)
		@optionset.each do |option_item|
			if option_item.get_response == option_string
				option_item.add_credit(new_credit)
			end
		end
	end

	def setask(answer=nil)
		if answer!=nil && @status!="committed"
			@choice_selected=answer
		elsif @status!="committed"
			@choice_selected=$hash_guess[@name].call.get_answer
			modify_credit(@choice_selected,$hash_guess[@name].call.get_credit)
		end
		@status = "ask"
		if $hash_guess[@name].call.get_credit>@@credit_threshold
			@hide=1
		end
	end
	def get_hide
		return @hide
	end
	def answered(option_selected)
		@status = "answered"
		@choice_selected = option_selected
	end
	def commit(option_selected)
		@status = "committed"
		@choice_selected = option_selected
	end
	def unask
		@status = "created"
	end
	def get_optionset
		return @optionset
	end
	def get_query_string
		return @query_string
	end
	def get_name
		return @name
	end
	def get_status
		return @status
	end
	def get_answer
		return @choice_selected
	end
	#Add a new Association to the association_list of the Question
	def add_association(local_response,remote_question,remote_response,credit_modifier)
		@association_list.push(Association.new(local_response,remote_question,remote_response,credit_modifier))
	end
	#Returns option with maximum credit
=begin	def option_max_credit
		credit_array = Array.new
		@optionset.each do |option_item|
			credit_array.push(option_item.credit)
		end
	end
=end	#check with the association class for dependencies and update credits for the dependent options
	def update_dependents_credit
		@association_list.each do |association_item|
			if association_item.local_response == self.choice_selected
				question_queue.each do |question_item|
				if question_item.query_string==association_item.remote_question && question_item.status=="answered"
					question_item.optionset.each do |option_item|
					if option_item.response==association_list.remote_response
						option_item.credit = option_item+association_list.credit_modifier
					end
					end
				end
				end
			end
		end
	end
end



class Pkgvars

	@@pkg_name = String.new
	@@src_path = String.new
	@@patch_path = String.new
	@@version = String.new
	@@release = String.new
	@@arch = String.new
	@@license = String.new
	@@distro = String.new
	@@group = String.new
	@@section = String.new
	@@buildroot = String.new
	@@configure_args = String.new
	@@cflags = String.new
	@@cxxflags = String.new
	@@extra_configure_args = String.new
	@@make_args = String.new
	@@install_args = String.new
	@@maintainer = String.new
	@@summary = String.new
	@@Description = String.new
	@@packager_name = String.new
	@@packager_email = String.new
	@@changes = String.new

	def Pkgvars.set_var(var_name,value)
		case var_name
			when "pkg_name"
			@@pkg_name = value
			when "src_path"
			@@src_path = value
			if(@@pkg_name == "")
			@@pkg_name = File.basename(@@src_path).split("-")[0]
			end
			when "patch_path"
			@@patch_path = value
			when "version"
			@@version = value
			when "release"
			@@release = value
			when "arch"
			@@arch = value
			when "license"
			@@license = value
			when "distro"
			@@distro = value
			when "group"
			@@group = value
			when "section"
			@@section = value
			when "buildroot"
			@@buildroot = value
			when "configure_args"
			@@configure_args = value
			when "cflags"
			@@cflags = value
			when "cxxflags"
			@@cxxflags = value
			when "extra_configure_args"
			@@extra_configure_args = value
			when "make_args"
			@@make_args = value
			when "install_args"
			@@install_args = value
			when "maintainer"
			@@maintainer = value
			when "summary"
			@@summary = value
			when "description"
			@@description = value
			when "packager_name"
			@@packager_name = value
			when "packager_email"
			@@packager_email = value
			when "changes"
			@@changes = value
		end
	end
	
	def Pkgvars.get_pkg_name
		return @@pkg_name
	end
	
	def Pkgvars.get_src_path
		return @@src_path
	end

	def Pkgvars.get_patch_path
		return @@patch_path
	end
	
	def Pkgvars.get_version
		return @@version
	end

	def Pkgvars.get_release
		return @@release
	end

	def Pkgvars.get_arch
		return @@arch
	end
	
	def Pkgvars.get_license
		return @@license
	end
	
	def Pkgvars.get_distro
		return @@distro
	end
	
	def Pkgvars.get_group
		return @@group
	end
	
	def Pkgvars.get_section
		return @@section
	end

	def Pkgvars.get_buildroot
		return @@buildroot
	end

	def Pkgvars.get_configure_args
		return @@configure_args
	end

	def Pkgvars.get_cflags
		return @@cflags
	end

	def Pkgvars.get_cxxflags
		return @@cxxflags
	end

	def Pkgvars.get_extra_configure_args
		return @@extra_configure_args
	end

	def Pkgvars.get_make_args
		return @@make_args
	end

	def Pkgvars.get_install_args
		return @@install_args
	end
	
	def Pkgvars.get_maintainer
                return @@maintainer
        end
	
        def Pkgvars.get_summary
                return @@summary
        end
	
        def Pkgvars.get_description
                return @@description
        end
	
	def Pkgvars.get_packager_name
		return @@packager_name
	end

	def Pkgvars.get_packager_email
		return @@packager_email
	end

	def Pkgvars.get_changes
		return @@changes
	end

end


class Sysvars

        @@rpm_build_root="/tmp/tmproot/"
        @@source_dir="#{get_homedir}/.apbd/SOURCES"
        @@extracted_dir=String.new
        def Sysvars.set_source_dir(dir)
                @@source_dir = dir
        end
        def Sysvars.set_rpm_build_root(dir)
                @@rpm_build_root = dir
        end
        def Sysvars.set_extracted_dir(dir)
                @@extracted_dir = "#{Sysvars.get_source_dir}/#{File.basename(dir)}"
        end
        def Sysvars.get_source_dir
                return @@source_dir
        end
        def Sysvars.get_rpm_build_root
                return @@rpm_build_root
        end
        def Sysvars.get_extracted_dir
                return @@extracted_dir
        end
end

