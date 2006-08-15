require 'Qt'
require 'Classes.rb'

class Question_options_widget < Qt::Widget
	
  def initialize(name,label,options)
  	super(nil)
    @hbox = Qt::HBox.new(self)
    @lbl = Qt::Label.new(@hbox,label)
    @lbl.setText(label)
    @bgrp = Qt::ButtonGroup.new(1,Qt::GroupBox::Horizontal,"Button Group 1 (exclusive)", @hbox)
    @box = QVBoxLayout.new( @hbox ,11,6)
#		@box.addWidget(@bgrp)
#		@bgrp.setExclusive(TRUE)
#insert radiobuttons
#		options.each do |option_item|
#			QRadioButton.new(option_item.response,bgrp)
#		end
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

def generate_question_widget(question_queue)

	a = Qt::Application.new(ARGV)
	w = Qt::HBox.new

	question_queue.each do |question_item|
		if question_item.get_optionset.size==0
			w = Question_text_widget.new(question_item.get_name,question_item.get_query_string)
		else
			w = Question_options_widget.new(question_item.get_name,question_item.get_query_string,question_item.get_optionset)
		end
	end

	a.mainWidget = w
	w.show
	a.exec
end


##########################
#Test the above functions#
##########################
Question.create_yes_no("sample","Test Query")
##Comment out the previous line and Uncomment the next line to see that it works for the Question_text_widget class
#Question.create_text_question("sample","Test Query")
generate_question_widget(Question.get_question_queue)

##########################
#Testing ends            #
##########################
