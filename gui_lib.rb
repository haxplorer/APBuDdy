require 'Qt'
require 'Classes.rb'
require 'quickspec_new.rb'

class Question_options_widget < Qt::Widget
	
	def initialize(name,label,options)
  		super(nil)
		@hbox = Qt::HBox.new(self)
		@lbl = Qt::Label.new(@hbox,label)
		@lbl.setText(label)
		@bgrp = Qt::ButtonGroup.new(1,Qt::GroupBox::Horizontal,"Button Group 1 (exclusive)", @hbox)
		@box = Qt::VBoxLayout.new(@hbox)
		@box.addWidget(@bgrp)
		@bgrp.setExclusive(TRUE)
#insert radiobuttons
		options.each do |option_item|
			Qt::RadioButton.new(option_item.get_response,@bgrp)
		end
	end
end

class Question_text_widget < Qt::Widget
	def initialize(name,label)
		super
		@hbox = Qt::HBox.new(self)
		@lbl = Qt::Label.new(@hbox,label)
		@lbl.setText(label)
		@txt = Qt::LineEdit.new(@hbox,name)
	end
end

def generate_question_widget_list(w,question_queue)
#	widget_list = Array.new
	question_queue.each do |question_item|
		if question_item.get_optionset.size==0
			w.addwidget_to_wstack(Question_text_widget.new(question_item.get_name,question_item.get_query_string))
		else
			w.addwidget_to_wstack(Question_options_widget.new(question_item.get_name,question_item.get_query_string,question_item.get_optionset))
		end
	end
#	return widget_list
end


=begin
##########################
#Test the above functions#
##########################
Question.create_yes_no("sample","Test Query")
##Comment out the previous line and Uncomment the next line to see that it works for the Question_text_widget class
Question.create_text_question("sample","Test Query")
generate_question_widget(Question.get_question_queue)

##########################
#Testing ends            #
##########################
=end
