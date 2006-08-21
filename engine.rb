#!/usr/bin/env ruby

require 'static_gui.rb'
require 'Classes.rb'
require 'gui_lib.rb'
require 'questions.rb'
require 'lib.rb'
require 'gnu_configure.rb'


def engine(w,count)
case count
when 0
	Question.get_question_byname("pkg_name").setask
	Question.get_question_byname("src_path").setask
	generate_question_widget_list(w,Question.get_question_queue)
when 1
	w.proc_outbox_append("Trying to unpack file. Please Wait...")
	if file_get_unpack == 0
		w.proc_outbox_append("The selected file is invalid")
	end
	w.proc_outbox_append("Unpacking successful")
        Question.get_question_byname("version").setask(get_version)
        Question.get_question_byname("release").setask
	w.proc_outbox_append("Finding the processor architecture")
	Question.get_question_byname("arch").setask
	w.proc_outbox_append("Searching for license..")
	Question.get_question_byname("license").setask(find_license_type)
	w.proc_outbox_append("Detecting distribution..")
	Question.get_question_byname("distro").setask(find_distro)
	Question.get_question_byname("group").setask
	Question.get_question_byname("section").setask
	generate_question_widget_list(w,Question.get_question_queue)
when 2
	Question.get_question_byname("buildroot").setask(Sysvars.get_rpm_build_root)
	Question.get_question_byname("configure_args").setask
        generate_question_widget_list(w,Question.get_question_queue)
	w.proc_outbox_append("Trying to configure... Please Wait..")
when 3
	Phase.phase_queue_concat(gnu_configure_check_create)
	Phase.run_phase_queue
	w.proc_outbox_append("Job Done.. You may Quit now")
end
end

generate_predefined_questions
a = Qt::Application.new(ARGV)
w = FrmMain.new
a.mainWidget = w
w.show
engine(w,0)
a.exec
