require 'quickspec_new.rb'
require 'Classes.rb'
require 'gui_lib.rb'
#th = Thread.new do
	Question.create_yes_no("sample","Test Query")
##Comment out the previous line and Uncomment the next line to see that it works for the Question_text_widget class
	Question.create_text_question("sample","Test Query")
	a = Qt::Application.new(ARGV)
	w = FrmMain.new
	generate_question_widget_list(w,Question.get_question_queue)
	w.repaint()
	a.mainWidget = w
	w.show
	a.exec
#end

