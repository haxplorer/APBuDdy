# Form implementation generated from reading ui file 'quickspec.ui'
#
# Created: Sun Jul 9 22:23:26 2006
#      by: The QtRuby User Interface Compiler (rbuic)
#
# WARNING! All changes made in this file will be lost!


require 'Qt'
require 'lib.rb'
require 'gui_lib.rb'
require 'gnu_configure.rb'
require 'Classes.rb'

class FrmMain < Qt::MainWindow

    slots 'languageChange()',
    'fileExit()',
    'helpIndex()',
    'helpContents()',
    'helpAbout()',
    'extrasSavePoints()',
    'goBack()',
    'goNext()',
    'selectFile()',
    'fileStartAgain()',
    'fileImportTemplate()'

    attr_reader :txtprocessoutput
    attr_reader :btnBack
    attr_reader :btnNext
    attr_reader :btnQuit
    attr_reader :wstackMain
    attr_reader :wspSelectPkg
    attr_reader :txtPkgName
    attr_reader :lblpkgnamenotify
    attr_reader :lblPkgName
    attr_reader :lblFilePath
    attr_reader :txtSrcFile
    attr_reader :btnBrowse
    attr_reader :wspFillHeader
    attr_reader :lblVersion
    attr_reader :lblRelease
    attr_reader :lblLicense
    attr_reader :lblGroup
    attr_reader :lblSection
    attr_reader :txtVersion
    attr_reader :txtRelease
    attr_reader :txtLicense
    attr_reader :txtGroup
    attr_reader :txtSection
    attr_reader :wspFillDesc
    attr_reader :lblSummary
    attr_reader :lblDescription
    attr_reader :txtSummary
    attr_reader :txtDescription
    attr_reader :progressBar

    @@image0_data = [ 
0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, 0x00, 0x00, 0x00, 0x0d,
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x10,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1f, 0xf3, 0xff, 0x61, 0x00, 0x00, 0x01,
    0x8e, 0x49, 0x44, 0x41, 0x54, 0x38, 0x8d, 0x95, 0x93, 0x3f, 0x4b, 0x1c,
    0x51, 0x14, 0xc5, 0x7f, 0x77, 0x33, 0x96, 0xe2, 0x07, 0x90, 0x94, 0x62,
    0x67, 0xd4, 0xc2, 0xef, 0x20, 0x49, 0x13, 0x05, 0x0b, 0x0b, 0x21, 0x85,
    0x88, 0x85, 0xa8, 0x20, 0x82, 0xb0, 0x04, 0x02, 0x2a, 0x04, 0x44, 0x12,
    0x2c, 0x6c, 0xfc, 0x0a, 0x82, 0x5b, 0xd9, 0xa4, 0xb1, 0x14, 0x82, 0xa2,
    0xec, 0x6e, 0x63, 0x67, 0x48, 0x61, 0xa1, 0x2b, 0x2e, 0xb3, 0x6f, 0xfe,
    0xbd, 0xbd, 0x16, 0x6f, 0x66, 0x67, 0x75, 0xd8, 0x15, 0x0f, 0x0c, 0x97,
    0xfb, 0xee, 0xdc, 0x73, 0xcf, 0x3d, 0x33, 0x4f, 0x48, 0x31, 0xb9, 0x71,
    0xa3, 0x28, 0x08, 0xa0, 0x22, 0x80, 0x02, 0x70, 0xb1, 0x37, 0x22, 0xbc,
    0x85, 0x89, 0xb5, 0xba, 0xfa, 0xb1, 0x55, 0x3f, 0xb4, 0x79, 0x4c, 0x9f,
    0x89, 0xb5, 0xba, 0xf6, 0xeb, 0xf5, 0xc6, 0x57, 0xae, 0xf5, 0x74, 0x67,
    0x94, 0x66, 0x94, 0x9e, 0xa4, 0xc3, 0x33, 0x0d, 0x63, 0x83, 0x37, 0xb0,
    0x72, 0xa5, 0x2a, 0x20, 0x08, 0x8a, 0x76, 0xea, 0x97, 0x07, 0x9f, 0xc4,
    0xc3, 0x46, 0x34, 0xe3, 0x22, 0xb3, 0xb6, 0x41, 0x4a, 0x50, 0x5e, 0xff,
    0xe2, 0x72, 0x5c, 0x4e, 0x1b, 0x28, 0xb9, 0x7c, 0xce, 0xfe, 0x55, 0x4f,
    0x93, 0x88, 0xc7, 0xa0, 0x8f, 0x46, 0x81, 0xf9, 0xcd, 0x6a, 0x8f, 0xe2,
    0x00, 0x9e, 0xda, 0x88, 0x87, 0x54, 0xfe, 0x07, 0xc0, 0x66, 0x51, 0x5d,
    0x5c, 0xfe, 0x5e, 0x65, 0x6b, 0xe9, 0x23, 0x0b, 0x53, 0x43, 0x2f, 0x5a,
    0x4f, 0x6a, 0xb0, 0xb5, 0x5f, 0xc5, 0xd3, 0xb6, 0x75, 0x0a, 0x04, 0xca,
    0xdb, 0xc5, 0x49, 0xdf, 0xe6, 0x87, 0x59, 0x98, 0x1a, 0xe2, 0xd7, 0x19,
    0xd8, 0xec, 0x7b, 0x74, 0xd9, 0xea, 0xa9, 0x8d, 0x79, 0x0c, 0xe1, 0xe7,
    0xee, 0x05, 0xd3, 0x5f, 0x27, 0xf9, 0x3d, 0x53, 0x14, 0xba, 0x7a, 0x4c,
    0xee, 0x6a, 0x17, 0x6c, 0x14, 0xe3, 0x69, 0x12, 0xd2, 0x08, 0xc0, 0x86,
    0x11, 0xff, 0x1f, 0x60, 0xf6, 0x28, 0x9f, 0x22, 0x52, 0xe8, 0xc9, 0x79,
    0x14, 0x92, 0x30, 0x74, 0x2b, 0x3c, 0x85, 0x60, 0x4d, 0xc0, 0x5d, 0x23,
    0x7d, 0x23, 0x93, 0xd9, 0x3d, 0xb5, 0xfb, 0x77, 0x4a, 0x6b, 0xd6, 0x04,
    0xce, 0xc4, 0x66, 0x04, 0x89, 0x09, 0x68, 0xf8, 0x3d, 0x9a, 0x5f, 0x1d,
    0x65, 0x5c, 0xb6, 0x15, 0x38, 0x0f, 0xfc, 0x10, 0x62, 0xe3, 0x53, 0xfb,
    0x51, 0xdc, 0xbf, 0x17, 0x2a, 0x95, 0x73, 0x16, 0xff, 0x18, 0x4a, 0xb4,
    0x93, 0x0e, 0xdb, 0x7b, 0x61, 0x5b, 0x2d, 0x3c, 0xb5, 0x09, 0xf7, 0x06,
    0xe2, 0xc0, 0x50, 0xa9, 0x9c, 0xbf, 0x8b, 0x20, 0x09, 0x8c, 0x5b, 0x67,
    0xf4, 0xf3, 0xa1, 0xde, 0x5e, 0x47, 0x79, 0x45, 0xe0, 0xc5, 0xd6, 0x2a,
    0x20, 0xaf, 0xdc, 0x54, 0x30, 0xff, 0x56, 0x45, 0x54, 0xfb, 0x5e, 0xb6,
    0x37, 0xf1, 0x0c, 0xc3, 0x88, 0xd2, 0x50, 0xff, 0x19, 0x2d, 0xeb, 0x00,
    0x00, 0x00, 0x00, 0x49, 0x45, 0x4e, 0x44, 0xae, 0x42, 0x60, 0x82 ].pack "C*"


    def initialize(parent = nil, name = nil, fl = WType_TopLevel)
        super

        @image0 = Qt::Pixmap.new()
        @image0.loadFromData(@@image0_data, @@image0_data.length, "PNG")

        statusBar()
        if name.nil?
        	setName("FrmMain")
        end

        setCentralWidget(Qt::Widget.new(self, "qt_central_widget"))

        @txtprocessoutput = Qt::TextEdit.new(centralWidget(), "txtprocessoutput")
        @txtprocessoutput.setReadOnly( true )
        @txtprocessoutput.setGeometry( Qt::Rect.new(30, 360, 491, 102) )

        @btnBack = Qt::PushButton.new(centralWidget(), "btnBack")
        @btnBack.setGeometry( Qt::Rect.new(180, 470, 81, 30) )

        @btnNext = Qt::PushButton.new(centralWidget(), "btnNext")
        @btnNext.setGeometry( Qt::Rect.new(280, 470, 81, 30) )

        @btnQuit = Qt::PushButton.new(centralWidget(), "btnQuit")
        @btnQuit.setGeometry( Qt::Rect.new(420, 470, 81, 30) )

        @wstackMain = Qt::WidgetStack.new(centralWidget(), "wstackMain")
        @wstackMain.setGeometry( Qt::Rect.new(30, 30, 490, 320) )

        @wspSelectPkg = Qt::Widget.new(@wstackMain, "wspSelectPkg")

        @txtPkgName = Qt::LineEdit.new(@wspSelectPkg, "txtPkgName")
        @txtPkgName.setGeometry( Qt::Rect.new(160, 40, 201, 29) )

        @lblpkgnamenotify = Qt::Label.new(@wspSelectPkg, "lblpkgnamenotify")
        @lblpkgnamenotify.setGeometry( Qt::Rect.new(20, 80, 440, 100) )
        @lblpkgnamenotify.setAlignment( Qt::Label::WordBreak | Qt::Label::AlignVCenter )

        @lblPkgName = Qt::Label.new(@wspSelectPkg, "lblPkgName")
        @lblPkgName.setGeometry( Qt::Rect.new(20, 40, 121, 30) )

        @lblFilePath = Qt::Label.new(@wspSelectPkg, "lblFilePath")
        @lblFilePath.setGeometry( Qt::Rect.new(20, 200, 121, 30) )

        @txtSrcFile = Qt::LineEdit.new(@wspSelectPkg, "txtSrcFile")
        @txtSrcFile.setGeometry( Qt::Rect.new(160, 200, 201, 29) )

        @btnBrowse = Qt::PushButton.new(@wspSelectPkg, "btnBrowse")
        @btnBrowse.setGeometry( Qt::Rect.new(370, 200, 30, 30) )
        @btnBrowse.setPixmap( @image0 )
        @wstackMain.addWidget( @wspSelectPkg, 0 )

        @wspFillHeader = Qt::Widget.new(@wstackMain, "wspFillHeader")

        @lblVersion = Qt::Label.new(@wspFillHeader, "lblVersion")
        @lblVersion.setGeometry( Qt::Rect.new(20, 40, 121, 30) )

        @lblRelease = Qt::Label.new(@wspFillHeader, "lblRelease")
        @lblRelease.setGeometry( Qt::Rect.new(20, 100, 121, 30) )

        @lblLicense = Qt::Label.new(@wspFillHeader, "lblLicense")
        @lblLicense.setGeometry( Qt::Rect.new(20, 160, 121, 30) )

        @lblGroup = Qt::Label.new(@wspFillHeader, "lblGroup")
        @lblGroup.setGeometry( Qt::Rect.new(20, 220, 121, 30) )

        @lblSection = Qt::Label.new(@wspFillHeader, "lblSection")
        @lblSection.setGeometry( Qt::Rect.new(20, 280, 121, 30) )

        @txtVersion = Qt::LineEdit.new(@wspFillHeader, "txtVersion")
        @txtVersion.setGeometry( Qt::Rect.new(160, 40, 201, 29) )

        @txtRelease = Qt::LineEdit.new(@wspFillHeader, "txtRelease")
        @txtRelease.setGeometry( Qt::Rect.new(160, 100, 201, 29) )

        @txtLicense = Qt::LineEdit.new(@wspFillHeader, "txtLicense")
        @txtLicense.setGeometry( Qt::Rect.new(160, 160, 201, 29) )

        @txtGroup = Qt::LineEdit.new(@wspFillHeader, "txtGroup")
        @txtGroup.setGeometry( Qt::Rect.new(160, 220, 201, 29) )

        @txtSection = Qt::LineEdit.new(@wspFillHeader, "txtSection")
        @txtSection.setGeometry( Qt::Rect.new(160, 280, 201, 29) )
        @wstackMain.addWidget( @wspFillHeader, 1 )

        @wspFillDesc = Qt::Widget.new(@wstackMain, "wspFillDesc")

        @lblSummary = Qt::Label.new(@wspFillDesc, "lblSummary")
        @lblSummary.setGeometry( Qt::Rect.new(20, 40, 121, 30) )

        @lblDescription = Qt::Label.new(@wspFillDesc, "lblDescription")
        @lblDescription.setGeometry( Qt::Rect.new(20, 100, 121, 30) )

        @txtSummary = Qt::LineEdit.new(@wspFillDesc, "txtSummary")
        @txtSummary.setGeometry( Qt::Rect.new(160, 40, 201, 29) )

        @txtDescription = Qt::TextEdit.new(@wspFillDesc, "txtDescription")
        @txtDescription.setGeometry( Qt::Rect.new(160, 100, 201, 121) )
        @wstackMain.addWidget( @wspFillDesc, 2 )

        @progressBar = Qt::ProgressBar.new(centralWidget(), "progressBar")
        @progressBar.setGeometry( Qt::Rect.new(40, 530, 470, 33) )
        @progressBar.setProgress( 0 )

        @fileExitAction= Qt::Action.new(self, "fileExitAction")
        @helpContentsAction= Qt::Action.new(self, "helpContentsAction")
        @helpIndexAction= Qt::Action.new(self, "helpIndexAction")
        @helpAboutAction= Qt::Action.new(self, "helpAboutAction")
        @fileNewImport_templateAction= Qt::Action.new(self, "fileNewImport_templateAction")
        @extrasSavePointsAction= Qt::Action.new(self, "extrasSavePointsAction")
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
        @extrasSavePointsAction.addTo( @Extras )
        @MenuBar.insertItem( "", @Extras, 2 )

        @helpMenu = Qt::PopupMenu.new( self )
        @helpContentsAction.addTo( @helpMenu )
        @helpIndexAction.addTo( @helpMenu )
        @helpMenu.insertSeparator()
        @helpAboutAction.addTo( @helpMenu )
        @MenuBar.insertItem( "", @helpMenu, 3 )

        languageChange()
        resize( Qt::Size.new(550, 630).expandedTo(minimumSizeHint()) )
        clearWState( WState_Polished )

        Qt::Object.connect(@fileExitAction, SIGNAL("activated()"), self, SLOT("fileExit()") )
        Qt::Object.connect(@helpIndexAction, SIGNAL("activated()"), self, SLOT("helpIndex()") )
        Qt::Object.connect(@helpContentsAction, SIGNAL("activated()"), self, SLOT("helpContents()") )
        Qt::Object.connect(@helpAboutAction, SIGNAL("activated()"), self, SLOT("helpAbout()") )
        Qt::Object.connect(@btnQuit, SIGNAL("clicked()"), self, SLOT("close()") )
        Qt::Object.connect(@extrasSavePointsAction, SIGNAL("activated()"), self, SLOT("extrasSavePoints()") )
        Qt::Object.connect(@btnBack, SIGNAL("clicked()"), self, SLOT("goBack()") )
        Qt::Object.connect(@btnNext, SIGNAL("clicked()"), self, SLOT("goNext()") )
        Qt::Object.connect(@btnBrowse, SIGNAL("clicked()"), self, SLOT("selectFile()") )
        Qt::Object.connect(@fileStart_AgainAction, SIGNAL("activated()"), self, SLOT("fileStartAgain()") )
        Qt::Object.connect(@fileNewImport_templateAction, SIGNAL("activated()"), self, SLOT("fileImportTemplate()") )

        setTabOrder(@txtPkgName, @txtSrcFile)
        setTabOrder(@txtSrcFile, @btnBrowse)
        setTabOrder(@btnBrowse, @txtVersion)
        setTabOrder(@txtVersion, @txtRelease)
        setTabOrder(@txtRelease, @txtLicense)
        setTabOrder(@txtLicense, @txtGroup)
        setTabOrder(@txtGroup, @txtSection)
        setTabOrder(@txtSection, @txtSummary)
        setTabOrder(@txtSummary, @txtDescription)
        setTabOrder(@txtDescription, @btnBack)
        setTabOrder(@btnBack, @btnNext)
        setTabOrder(@btnNext, @btnQuit)
        setTabOrder(@btnQuit, @txtprocessoutput)
    end

    #
    #  Sets the strings of the subwidgets using the current
    #  language.
    #
    def languageChange()
        setCaption(trUtf8("Quickspec"))
        @btnBack.setText( trUtf8("Bac&k") )
        @btnBack.setAccel( Qt::KeySequence.new(trUtf8("Alt+K")) )
        @btnNext.setText( trUtf8("Ne&xt") )
        @btnNext.setAccel( Qt::KeySequence.new(trUtf8("Alt+X")) )
        @btnQuit.setText( trUtf8("&Quit") )
        @btnQuit.setAccel( Qt::KeySequence.new(trUtf8("Alt+Q")) )
        @lblpkgnamenotify.setText( trUtf8("If you don't select a file in the \"Source File\" field, the Package Name that you enter here would be used to find the package on the internet.") )
        @lblPkgName.setText( trUtf8("Package Name") )
        @lblFilePath.setText( trUtf8("Source File") )
        @btnBrowse.setText( nil )
        @lblVersion.setText( trUtf8("Version") )
        @lblRelease.setText( trUtf8("Release") )
        @lblLicense.setText( trUtf8("License") )
        @lblGroup.setText( trUtf8("Group") )
        @lblSection.setText( trUtf8("Section") )
        @lblSummary.setText( trUtf8("Summary") )
        @lblDescription.setText( trUtf8("Description") )
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
        @extrasSavePointsAction.setText(trUtf8("SavePoints"))
        @extrasSavePointsAction.setMenuText(trUtf8("SavePoints"))
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
end

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    w = FrmMain.new
    a.mainWidget = w
    w.show
    a.exec
end

