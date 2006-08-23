# Form implementation generated from reading ui file 'profile_gui.ui'
#
# Created: Tue Aug 22 11:47:38 2006
#      by: The QtRuby User Interface Compiler (rbuic)
#
# WARNING! All changes made in this file will be lost!



require 'Qt'

class FrmProfile < Qt::Dialog

    slots 'languageChange()',
    'profile_write()'

    attr_reader :lblWelcome
    attr_reader :lblQuery
    attr_reader :btnOK
    attr_reader :bgrpQuery
    attr_reader :radioAverage
    attr_reader :radioGood
    attr_reader :radioNewbie


    def initialize(parent = nil, name = nil, modal = false, fl = 0)
        super

        if name.nil?
        	setName("FrmProfile")
        end


        @lblWelcome = Qt::Label.new(self, "lblWelcome")
        @lblWelcome.setGeometry( Qt::Rect.new(140, 40, 150, 41) )

        @lblQuery = Qt::Label.new(self, "lblQuery")
        @lblQuery.setGeometry( Qt::Rect.new(20, 120, 190, 40) )
        @lblQuery.setAlignment( Qt::Label::WordBreak | Qt::Label::AlignCenter )

        @btnOK = Qt::PushButton.new(self, "btnOK")
        @btnOK.setGeometry( Qt::Rect.new(340, 290, 60, 31) )

        @bgrpQuery = Qt::ButtonGroup.new(self, "bgrpQuery")
        @bgrpQuery.setGeometry( Qt::Rect.new(220, 120, 190, 120) )
        @bgrpQuery.setExclusive( true )

        @radioAverage = Qt::RadioButton.new(@bgrpQuery, "radioAverage")
        @radioAverage.setGeometry( Qt::Rect.new(20, 50, 100, 20) )

        @radioGood = Qt::RadioButton.new(@bgrpQuery, "radioGood")
        @radioGood.setGeometry( Qt::Rect.new(20, 80, 100, 20) )

        @radioNewbie = Qt::RadioButton.new(@bgrpQuery, "radioNewbie")
        @radioNewbie.setGeometry( Qt::Rect.new(20, 20, 100, 20) )
        @radioNewbie.setChecked( true )
        languageChange()
        resize( Qt::Size.new(446, 340).expandedTo(minimumSizeHint()) )
        clearWState( WState_Polished )

        Qt::Object.connect(@btnOK, SIGNAL("pressed()"), self, SLOT("profile_write()") )
    end

    #
    #  Sets the strings of the subwidgets using the current
    #  language.
    #
    def languageChange()
        setCaption(trUtf8("Select your profile"))
        @lblWelcome.setText( trUtf8("<h1>Welcome</h1>") )
        @lblQuery.setText( trUtf8("Knowledge in packaging") )
        @btnOK.setText( trUtf8("ok") )
        @bgrpQuery.setTitle( nil )
        @radioAverage.setText( trUtf8("Average") )
        @radioGood.setText( trUtf8("Good") )
        @radioNewbie.setText( trUtf8("Newbie") )
    end
    protected :languageChange


    def profile_write(*k)
	path = `echo $HOME`.chomp
	system("mkdir #{path}/.apbd/")
	File.new("#{path}/.apbd/.profile","w").print(@bgrpQuery.selected.text)
	close()
    end

end
