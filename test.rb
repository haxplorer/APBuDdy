require 'Qt'
require 'mylib.rb'
a = Qt::Application.new(ARGV)

w = MyWidget.new
a.setMainWidget(w)
w.show
a.exec
