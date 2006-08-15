require 'Qt'
require 'Classes.rb'

class Question_options_widget < Qt::HBox
	def initialize(name,label,options)
        	super
#		@lbl = Qt::Label.new(self,label)
#		@lbl.setText(label)
#		@bgrp = QButtonGroup.new(1,QGroupBox::Horizontal,"Button Group 1 (exclusive)",self)
#		@box = QVBoxLayout.new(self,11,6)
#		@box.addWidget(@bgrp)
#		@bgrp.setExclusive(TRUE)
#insert radiobuttons
#		options.each do |option_item|
#			QRadioButton.new(option_item.response,bgrp)
#		end
        end
end
class Question_text_widget < Qt::HBox
	def initialize(name,label)
		super
		@lbl = Qt::Label.new(self,label)
		@lbl.setText(label)
		@txt = Qt::LineEdit.new(self,name)
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
Question.create_text_question("sample","Test Query")
generate_question_widget(Question.get_question_queue)

##########################
#Testing ends            #
##########################

=begin
def fileExit(*k)
	close()
end

def helpIndex(*k)
	print("FrmMain.helpIndex(): Not implemented yet.\n")
end

def helpContents(*k)
	print("FrmMain.helpContents(): Not implemented yet.\n")
end

def helpAbout(*k)
        print("FrmMain.helpAbout(): Not implemented yet.\n")
end

def extrasSavePoints(*k)
        print("FrmMain.extrasSavePoints(): Not implemented yet.\n")
end

def goBack(*k)
        wstackMain.raiseWidget(wstackMain.id(wstackMain.visibleWidget())-1)
end

def goNext(*k)
        package_path = "#{get_homedir()}/.quickspec/PACKAGES/#{File.basename(txtSrcFile.text())}"
        case wstackMain.id(wstackMain.visibleWidget())
        when 0
                if FileTest.exist?(txtSrcFile.text())
                        unpack(txtSrcFile.text())
                elsif txtSrcFile.text().split("://")[0]=="http" || txtSrcFile.text().split("://")[0]=="ftp"
                        Thread.new do
                        wgetproc = Qt::Process.new(self)
                        wgetproc.addArgument("wget")
#                       wgetproc.addArgument("--output-file=#{get_homedir()}/.quickspec/#{File.basename(package_path)}_wgetlog")
                        wgetproc.addArgument("--directory-prefix=#{get_homedir()}/.quickspec/PACKAGES")
                        wgetproc.addArgument("#{txtSrcFile.text()}")
                        wgetproc.start()
                        while wgetproc.isRunning() do
                                if wgetproc.readyReadStdout()
                                        txtprocessoutput.append(wgetproc.readStdout().to_s)
                                elsif wgetproc.readyReadStderr()
                                        txtprocessoutput.append(wgetproc.readStderr().to_s)
                                end
                        end
#                       fork do
                                unpack(package_path)
#                       end
#                       while !FileTest.exist?("/tmp/#{File.basename(package_path)}.qsx") do end
#                       previous_size = -1
#                       current_size = 0
#                       tarball_total_size = `wc -l /tmp/#{File.basename(package_path)}.qst | awk '{print $1}'`.to_i
#                       while current_size!=previous_size do
#                               previous_size = current_size
#                               current_size = `wc -l /tmp/#{File.basename(package_path)}.qsx | awk '{print $1}'`.to_i

#                       end
                        end
                else
                        txtprocessoutput.append("Unable to find archive.. Please reselect..")
                        return 0
                end
                Phase.phase_queue_concat(gnu_configure_check_create())
                txtprocessoutput.append("Unpacking successful")
                txtVersion.setText(get_version(package_path))
                extracted_dir = `awk -F "/" '{print $1}' /tmp/#{File.basename(package_path)}.qsx`.chomp
                Sysvars.set_source_dir("#{get_homedir()}/.quickspec/SOURCES/#{extracted_dir}")
                txtLicense.setText(find_license_type(Sysvars.get_source_dir))
        when 1

        when 2
                Thread.new do
                Phase.get_phase_queue.each do |phase_item|
                        puts phase_item.get_steps
                        configureproc = Qt::Process.new(self)
                        configureproc.addArgument("cd #{Sysvars.get_source_dir};#{phase_item.get_steps}")
                        configureproc.start()
                        while configureproc.isRunning() do
                        end
                end
                txtprocessoutput.append("Job Done. Quit Now..")
                end
        end
        wstackMain.raiseWidget(wstackMain.id(wstackMain.visibleWidget())+1)
end

def selectFile(*k)
        QFileDialog::getOpenFileName(get_homedir(),"Compressed(*.tar.gz,*.tar.bz2)",self,"open file dialog","Choose a file to open")
end

def fileStartAgain(*k)
        print("FrmMain.fileStartAgain(): Not implemented yet.\n")
end

def fileImportTemplate(*k)
        print("FrmMain.fileImportTemplate(): Not implemented yet.\n")
end

=end
