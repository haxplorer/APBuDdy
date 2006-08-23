require 'Qt'
require 'Classes.rb'

class Question_options_widget < Qt::Widget

	slots 'question_toggle()'
	def initialize(name,label,options,parent,answer,hidden)
  		super(parent)
		@name = name
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
			@radio = Qt::RadioButton.new(option_item.get_response,@bgrp)
			if(option_item.get_response==answer)
				@radio.setChecked(TRUE)
			end
		end
		if hidden==1
			@bgrp.setDisabled(true)
		end
                @chk = Qt::CheckBox.new(@hbox)
                Qt::Object.connect(@chk, SIGNAL("clicked()"), self, SLOT("question_toggle()") )
	end
	def get_answer
		return @bgrp.selected.text
	end
	def get_name
		return @name
	end
        def question_toggle()
                @bgrp.setDisabled(@bgrp.isEnabled)
        end

end



class Question_text_widget < Qt::Widget

	slots 'question_toggle()'
	def initialize(name,label,parent,answer,hidden)
		super(parent)
		@name = name
		@hbox = Qt::HBox.new(self)
		@hbox.setGeometry( Qt::Rect.new(40, 0, 390, 30) )
		@hbox.setSpacing(10)
		@lbl = Qt::Label.new(@hbox,label)
		@lbl.setText(label)
		@txt = Qt::LineEdit.new(@hbox,name)
		@txt.setText(answer)
		if hidden==1
			@txt.setDisabled(true)
		end
		@chk = Qt::CheckBox.new(@hbox)
	        Qt::Object.connect(@chk, SIGNAL("clicked()"), self, SLOT("question_toggle()") )

	end
	def get_answer
		return @txt.text()
	end
	def get_name
		return @name
	end
	def question_toggle()
		@txt.setDisabled(@txt.isEnabled)
	end

end



class Question_combo_widget < Qt::Widget

	slots 'question_toggle()'
        def initialize(name,label,options,parent,answer,hidden)
                super(parent)
                @name = name
                @hbox = Qt::HBox.new(self)
		@hbox.setGeometry( Qt::Rect.new(40, 0, 390, 30) )
                @lbl = Qt::Label.new(@hbox,label)
                @lbl.setText(label)
		@combo = Qt::ComboBox.new(@hbox,name)
                options.each do |option_item|
			@combo.insertItem(option_item.get_response)
                end
		if answer!=""
			@combo.setCurrentText(answer)
		end
		if hidden==1
			@combo.setDisabled(true)
		end
                @chk = Qt::CheckBox.new(@hbox)
                Qt::Object.connect(@chk, SIGNAL("clicked()"), self, SLOT("question_toggle()") )
        end
        def get_answer
                return @combo.currentText
        end
        def get_name
                return @name
        end
	def question_toggle()
                @combo.setDisabled(@combo.isEnabled)
        end

end



def generate_question_widget_list(w,question_queue)
	count = 0
	question_queue.each do |question_item|
	if question_item.get_status=="ask"
		if question_item.get_optionset.size==0
			w.addwidget_to_frm(Question_text_widget.new(question_item.get_name,question_item.get_query_string,w.get_main_box,question_item.get_answer,question_item.get_hide))
		elsif question_item.get_optionset.size==2
			w.addwidget_to_frm(Question_options_widget.new(question_item.get_name,question_item.get_query_string,question_item.get_optionset,w.get_main_box,question_item.get_answer,question_item.get_hide))
		else
			w.addwidget_to_frm(Question_combo_widget.new(question_item.get_name,question_item.get_query_string,question_item.get_optionset,w.get_main_box,question_item.get_answer,question_item.get_hide))
		end
	end
	end

end

def goback(widget)
	widget.get_btnBack.clicked
end

def goNext(widget)
	widget.get_btnNext.clicked
end
