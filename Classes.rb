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

#A class to represent each of the different phases in the program
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
                @@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.name==name_prev
                                @@phase_queue.insert(index,temp_phase)
                        end
                end
	end
        def Phase.phase_new_before(name,steps,name_next,enabled=0)
                temp_phase=new(name,steps,enabled)
                pos=0
                @@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.name==name_next
                              pos=index-1  
                        end
                end
                @@phase_queue.insert(pos,temp_phase)
	end
	def Phase.phase_queue_concat(ext_queue)
		@@phase_queue.concat(ext_queue)
	end
	def Phase.get_phase_queue()
		return @@phase_queue
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
end


#A Class to represent something like if optionX for questionA is true, optionY for questionB should gain N credits
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
	#use this to create an objective question
	def initialize(name,query_string,options,credits=[])
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
		@@question_queue.push(self)
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
	def answered(option_selected)
		@status = "answered"
		@choice_selected = option_selected
	end
	def commit
		@status = "committed"
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


class Sysvars
	@@rpm_build_root="/tmp/tmproot"
	@@source_dir=String.new
	def Sysvars.set_source_dir(dir)
		@@source_dir = dir
	end
	def Sysvars.set_rpm_build_root(dir)
		@@rpm_build_root = dir
	end
	def Sysvars.get_source_dir
		return @@source_dir
	end	
	def Sysvars.get_rpm_build_root
		return @@rpm_build_root
	end
end
