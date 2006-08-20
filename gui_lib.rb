require 'Qt'
require 'Classes.rb'

class Question_options_widget < Qt::Widget
	
	def initialize(name,label,options,parent)
  		super(parent)
		@hbox = Qt::HBox.new(self)
		@hbox.setGeometry( Qt::Rect.new(40, 0, 390, 30*(options.size+1)) )
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
	def initialize(name,label,parent)
		super(parent)
		@hbox = Qt::HBox.new(self)
		@hbox.setGeometry( Qt::Rect.new(40, 0, 390, 30) )
		@hbox.setSpacing(10)
		@lbl = Qt::Label.new(@hbox,label)
		@lbl.setText(label)
		@txt = Qt::LineEdit.new(@hbox,name)
	end
end

def generate_question_widget_list(w,question_queue)
	question_queue.each do |question_item|
		if question_item.get_optionset.size==0
			w.addwidget_to_frm(Question_text_widget.new(question_item.get_name,question_item.get_query_string,w.get_vboxMain))
		else
			w.addwidget_to_frm(Question_options_widget.new(question_item.get_name,question_item.get_query_string,question_item.get_optionset,w.get_vboxMain))
		end
	end

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
