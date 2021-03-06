# Form implementation generated from reading ui file 'quickspec_new.ui'
#
# Created: Sun Aug 20 01:39:41 2006
#      by: The QtRuby User Interface Compiler (rbuic)
#
# WARNING! All changes made in this file will be lost!


require 'Qt'
require 'gui_lib.rb'
require 'Classes.rb'
require 'profile_select.rb'



class FrmMain < Qt::MainWindow

    slots 'languageChange()',
    'fileExit()',
    'helpIndex()',
    'helpContents()',
    'helpAbout()',
    'extrasAddCommand()',
    'extrasChangeProfile()',
    'goBack()',
    'goNext()',
    'selectFile()',
    'fileStartAgain()',
    'fileImportTemplate()'

    attr_reader :btnBack
    attr_reader :btnNext
    attr_reader :txtprocessoutput
    attr_reader :btnQuit
    attr_reader :frmMain



    def initialize(parent = nil, name = nil, fl = WType_TopLevel)
        super

        statusBar()
        if name.nil?
        	setName("FrmMain")
        end

        setCentralWidget(Qt::Widget.new(self, "qt_central_widget"))
	
	@engine_count = 0

        @btnBack = Qt::PushButton.new(centralWidget(), "btnBack")
        @btnBack.setGeometry( Qt::Rect.new(180, 490, 81, 30) )

        @btnNext = Qt::PushButton.new(centralWidget(), "btnNext")
        @btnNext.setGeometry( Qt::Rect.new(280, 490, 81, 30) )

        @txtprocessoutput = Qt::TextEdit.new(centralWidget(), "txtprocessoutput")
        @txtprocessoutput.setEnabled( true )
	 @txtprocessoutput.setReadOnly( true )
        @txtprocessoutput.setGeometry( Qt::Rect.new(21, 365, 500, 112) )
	
	@lbltxtprocessoutput = Qt::Label.new(centralWidget(), "lblprocessoutput")
	@lbltxtprocessoutput.setText("Messages")
	@lbltxtprocessoutput.setGeometry( Qt::Rect.new(21, 350, 500, 15) )

        @btnQuit = Qt::PushButton.new(centralWidget(), "btnQuit")
        @btnQuit.setGeometry( Qt::Rect.new(420, 490, 81, 30) )

        @frmMain = Qt::Frame.new(centralWidget(), "frmMain")
        @frmMain.setGeometry( Qt::Rect.new(20, 25, 490, 310) )
        @frmMain.setFrameShape( Qt::Frame::GroupBoxPanel )
        @frmMain.setFrameShadow( Qt::Frame::Raised )

        @vboxMain = Qt::VBoxLayout.new(@frmMain,0,-1,"vboxMain")
	

        @fileExitAction= Qt::Action.new(self, "fileExitAction")
        @helpContentsAction= Qt::Action.new(self, "helpContentsAction")
        @helpIndexAction= Qt::Action.new(self, "helpIndexAction")
        @helpAboutAction= Qt::Action.new(self, "helpAboutAction")
        @fileNewImport_templateAction= Qt::Action.new(self, "fileNewImport_templateAction")
        @extrasAddCommandAction= Qt::Action.new(self, "extrasAddCommandAction")
	@extrasChangeProfileAction= Qt::Action.new(self, "extrasChangeProfileAction")
        @fileStart_AgainAction= Qt::Action.new(self, "fileStart_AgainAction")


        @MenuBar = Qt::MenuBar.new( self, "MenuBar" )


        @fileMenu = Qt::PopupMenu.new( self )
        @fileStart_AgainAction.addTo( @fileMenu )
        @fileNewImport_templateAction.addTo( @fileMenu )
        @fileMenu.insertSeparator()
        @fileMenu.insertSeparator()
        @fileExitAction.addTo( @fileMenu )
        @MenuBar.insertItem( "", @fileMenu, 1 )

        @Extras = Qt::PopupMenu.new( self )
        @extrasAddCommandAction.addTo( @Extras )
	@extrasChangeProfileAction.addTo( @Extras )
        @MenuBar.insertItem( "", @Extras, 2 )

        @helpMenu = Qt::PopupMenu.new( self )
        @helpContentsAction.addTo( @helpMenu )
        @helpIndexAction.addTo( @helpMenu )
        @helpMenu.insertSeparator()
        @helpAboutAction.addTo( @helpMenu )
        @MenuBar.insertItem( "", @helpMenu, 3 )

        languageChange()
        resize( Qt::Size.new(540, 576).expandedTo(minimumSizeHint()) )
        clearWState( WState_Polished )

        Qt::Object.connect(@fileExitAction, SIGNAL("activated()"), self, SLOT("fileExit()") )
        Qt::Object.connect(@helpIndexAction, SIGNAL("activated()"), self, SLOT("helpIndex()") )
        Qt::Object.connect(@helpContentsAction, SIGNAL("activated()"), self, SLOT("helpContents()") )
        Qt::Object.connect(@helpAboutAction, SIGNAL("activated()"), self, SLOT("helpAbout()") )
        Qt::Object.connect(@btnQuit, SIGNAL("clicked()"), self, SLOT("close()") )
        Qt::Object.connect(@extrasAddCommandAction, SIGNAL("activated()"), self, SLOT("extrasAddCommand()") )
	Qt::Object.connect(@extrasChangeProfileAction, SIGNAL("activated()"), self, SLOT("extrasChangeProfile()") )
        Qt::Object.connect(@btnBack, SIGNAL("clicked()"), self, SLOT("goBack()") )
        Qt::Object.connect(@btnNext, SIGNAL("clicked()"), self, SLOT("goNext()") )
        Qt::Object.connect(@fileStart_AgainAction, SIGNAL("activated()"), self, SLOT("fileStartAgain()") )
        Qt::Object.connect(@fileNewImport_templateAction, SIGNAL("activated()"), self, SLOT("fileImportTemplate()") )

        setTabOrder(@btnBack, @btnNext)
        setTabOrder(@btnNext, @btnQuit)
        setTabOrder(@btnQuit, @txtprocessoutput)
    end

    #
    #  Sets the strings of the subwidgets using the current
    #  language.
    #
    def languageChange()
        setCaption(trUtf8("Template System - Build your packages Easily"))
        @btnBack.setText( trUtf8("Bac&k") )
        @btnBack.setAccel( Qt::KeySequence.new(trUtf8("Alt+K")) )
        @btnNext.setText( trUtf8("Ne&xt") )
        @btnNext.setAccel( Qt::KeySequence.new(trUtf8("Alt+X")) )
        @btnQuit.setText( trUtf8("&Quit") )
        @btnQuit.setAccel( Qt::KeySequence.new(trUtf8("Alt+Q")) )
        @fileExitAction.setText(trUtf8("E&xit"))
        @fileExitAction.setMenuText(trUtf8("E&xit"))
        @fileExitAction.setAccel(Qt::KeySequence.new(nil))
        @helpContentsAction.setText(trUtf8("Contents"))
        @helpContentsAction.setMenuText(trUtf8("&Contents..."))
        @helpContentsAction.setAccel(Qt::KeySequence.new(nil))
        @helpIndexAction.setText(trUtf8("Index"))
        @helpIndexAction.setMenuText(trUtf8("&Index..."))
        @helpIndexAction.setAccel(Qt::KeySequence.new(nil))
        @helpAboutAction.setText(trUtf8("About"))
        @helpAboutAction.setMenuText(trUtf8("&About"))
        @helpAboutAction.setAccel(Qt::KeySequence.new(nil))
        @fileNewImport_templateAction.setText(trUtf8("From &Template"))
        @fileNewImport_templateAction.setMenuText(trUtf8("From &Template"))
        @fileNewImport_templateAction.setAccel(Qt::KeySequence.new(nil))
        @extrasAddCommandAction.setText(trUtf8("Add Command"))
        @extrasAddCommandAction.setMenuText(trUtf8("Add Command"))
	@extrasChangeProfileAction.setText(trUtf8("Change Profile"))
        @extrasChangeProfileAction.setMenuText(trUtf8("Change Profile"))
        @fileStart_AgainAction.setText(trUtf8("&Start Again"))
        @fileStart_AgainAction.setMenuText(trUtf8("&Start Again"))
        if !@MenuBar.findItem(1).nil?
                @MenuBar.findItem(1).setText( trUtf8("&File") )
        end
        if !@MenuBar.findItem(2).nil?
                @MenuBar.findItem(2).setText( trUtf8("Extras") )
        end
        if !@MenuBar.findItem(3).nil?
                @MenuBar.findItem(3).setText( trUtf8("&Help") )
        end
    end
    protected :languageChange


    def fileExit(*k)
	close
    end

    def helpIndex(*k)
	not_implemented
    end

    def helpContents(*k)
	not_implemented
    end

    def helpAbout(*k)
	not_implemented
    end

    def extrasAddCommand(*k)
	cmd_widget = Add_phase_widget.new
	cmd_widget.show
    end

    def extrasChangeProfile(*k)
	p = FrmProfile.new
	p.show
	Question.set_expertise(File.new("#{get_homedir}/.apbd/.profile").read)
    end

    def goBack(*k)
	clear_vbox
	Question.get_asked_list.each do |asked_item|
		Question.get_question_byname(asked_item.get_name).unask
        end
	Question.clear_asked_list
	@engine_count-=1
	engine(self,@engine_count)
	@btnNext.setEnabled(true)
    end

    def goNext(*k)
	Question.commit_all_asked
	clear_vbox
	@engine_count+=1
	Phase.run_phase_queue
	engine(self,@engine_count)
    end

    def clear_vbox
	Question.get_asked_list.each do |asked_item|
		@vboxMain.remove(asked_item)
	end
    end

    def engine_count_reduce
	@engine_count-=1
    end

    def engine_count_increase
	@engine_count+=1
    end

    def get_engine_count
	return @engine_count
    end

    def selectFile(*k)
	not_implemented
    end

    def fileStartAgain(*k)	
	while @engine_count>0
	get_btnBack.clicked
	end
    end

    def fileImportTemplate(*k)
	not_implemented
    end

    def addwidget_to_frm(widget)
        @vboxMain.addWidget(widget)
	Question.get_asked_list.push(widget)
        widget.show
    end

    def get_main_box
        return @frmMain
    end

    def get_proc_outbox
	return @txtprocessoutput
    end

    def proc_outbox_append(message)
	@txtprocessoutput.append(message)
    end

    def get_btnBack
	return @btnBack
    end

    def get_btnNext
	return @btnNext
    end

    def not_implemented
        msgbox=Qt::MessageBox.new()
        msgbox.setText("Will be available soon")
        msgbox.show

    end

end

=begin
if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    w = FrmMain.new
    a.mainWidget = w
    w.show
    a.exec
end
=end
