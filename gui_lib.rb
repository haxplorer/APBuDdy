require 'Qt'
require 'Classes.rb'
require 'lib.rb'

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


class Add_phase_widget < Qt::Dialog

        slots 'add_phase()',
	'load_patch_template()',
	'load_source_template()'
        def initialize(parent=nil)
                super(parent,"name",true)
		self.setGeometry( Qt::Rect.new(0, 0, 450, 120) )
		@vbox = Qt::VBox.new(self)
		@vbox.setGeometry( Qt::Rect.new(0, 0, 450, 120) )
                @hbox1 = Qt::HBox.new(@vbox)
                @hbox1.setGeometry( Qt::Rect.new(0, 0, 450, 30) )
                @lbl = Qt::Label.new(@hbox1)
                @lbl.setText("Name")
		@txt = Qt::LineEdit.new(@hbox1)
		@combo_pos = Qt::ComboBox.new(@hbox1)
                @combo_pos.insertItem("before")
		@combo_pos.insertItem("after")
		@combo_pos.insertItem("first")
		@combo_pos.insertItem("last")
                @combo_phase = Qt::ComboBox.new(@hbox1)
                Phase.get_phase_queue.each do |phase_item|
                        @combo_phase.insertItem(phase_item.get_name)
                end
		@btn_add = Qt::PushButton.new(@hbox1)
		@btn_add.setText("Add")
		@btn_cancel = Qt::PushButton.new(@hbox1)
		@btn_cancel.setText("Cancel")
		@hbox2 = Qt::HBox.new(@vbox)
		@hbox2.setGeometry( Qt::Rect.new(0, 40, 450, 60) )
		@lbl_cmds = Qt::Label.new(@hbox2)
		@lbl_cmds.setText("Commands")
		@txt_cmds = Qt::MultiLineEdit.new(@hbox2)
		@hbox3 = Qt::HBox.new(@vbox)
		@hbox3.setGeometry( Qt::Rect.new(0, 110, 450, 30) )
		@btn_Patch_template = Qt::PushButton.new(@hbox3)
		@btn_Patch_template.setText("Load Patch Template")
		@btn_Source_template = Qt::PushButton.new(@hbox3)
		@btn_Source_template.setText("Load Source Template")
	        Qt::Object.connect(@btn_add, SIGNAL("clicked()"), self, SLOT("add_phase()") )
		Qt::Object.connect(@btn_cancel, SIGNAL("clicked()"), self, SLOT("close()") )
		Qt::Object.connect(@btn_Patch_template, SIGNAL("clicked()"), self, SLOT("load_patch_template()") )
		Qt::Object.connect(@btn_Source_template, SIGNAL("clicked()"), self, SLOT("load_source_template()") )
        end

	def add_phase
		if(Pkgvars.get_src_path=="")
			msgbox=Qt::MessageBox.new()
			msgbox.setText("Sorry! You can do this only after specifying the Main Source File")
			msgbox.show
			return
		end
		if @txt.text.size>0 && @txt_cmds.text.split("@").size==1
			Phase.add_phase(@txt.text,@txt_cmds.text,@combo_pos.currentText,@combo_phase.currentText)
		elsif @txt_cmds.text.split("@").size>1
			if (@txt_cmds.text =~ /<path>/)!=nil
				msgbox=Qt::MessageBox.new()
	                        msgbox.setText("Invalid information")
        	                msgbox.show
                        return
			end
			puts "Patch or Source"
			Phase.add_patch_source(@txt.text,@txt_cmds.text,@combo_pos.currentText,@combo_phase.currentText)
		elsif @txt_cmds.text.size==0
			msgbox=Qt::MessageBox.new()
			msgbox.setText("Invalid information")
			msgbox.show
			return
		end
		close
	end
	
	def load_patch_template
		@txt_cmds.append("@Patch@0@<path>@")
	end

	def load_source_template
		@txt_cmds.append("@Source@@<path>@")
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
