#!/usr/bin/env ruby

require 'static_gui.rb'
require 'Classes.rb'
require 'gui_lib.rb'
require 'questions.rb'
require 'lib.rb'
require 'phases.rb'
require 'profile_select.rb'


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
		goback(w)
		return
	end
	w.proc_outbox_append("Unpacking successful")
	puts "version"
        Question.get_question_byname("version").setask
	puts "release"
        Question.get_question_byname("release").setask
	w.proc_outbox_append("Finding the processor architecture")
	puts "arch"
	Question.get_question_byname("arch").setask
	w.proc_outbox_append("Searching for license..")
	puts "license"
#	Question.get_question_byname("license").setask
	w.proc_outbox_append("Detecting distribution..")
	puts "distro"
	Question.get_question_byname("distro").setask
	puts "group"
	Question.get_question_byname("group").setask
	puts "section"
	Question.get_question_byname("section").setask
	generate_question_widget_list(w,Question.get_question_queue)
when 2
	Question.get_question_byname("maintainer").setask
	Question.get_question_byname("summary").setask
	Question.get_question_byname("description").setask
	generate_question_widget_list(w,Question.get_question_queue)
when 3
	Question.get_question_byname("buildroot").setask
	Question.get_question_byname("configure_args").setask
        generate_question_widget_list(w,Question.get_question_queue)
	w.proc_outbox_append("Trying to configure... Please Wait..")
when 4
	if(gnu_configure_check!=0)
		Phase.phase_push(generate_configure_phase)
	elsif (perl_check!=0)
		Phase.phase_push(generate_perl_makefile)
	end
	Phase.run_phase_queue
	if(gnu_make_check!=0)
		Phase.phase_push(generate_make_phase)
	end
	if(gnu_install_check!=0)
		Phase.phase_push(generate_install_phase)
	end
	Phase.run_phase_queue
	w.proc_outbox_append("Writing out Abstract Package Build Description")
	xml_writeout
	w.proc_outbox_append("Job Done.. You may Quit now")
end
end

generate_predefined_questions
if(!File.exist?("#{get_homedir}/.apbd/.profile"))
a = Qt::Application.new(ARGV)
p = FrmProfile.new
p.show
a.mainWidget = p
a.exec
end
Question.set_expertise(File.new("#{get_homedir}/.apbd/.profile").read)
a = Qt::Application.new(ARGV)
w = FrmMain.new
a.mainWidget = w
w.show
engine(w,w.get_engine_count)
a.exec
