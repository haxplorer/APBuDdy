require 'open-uri'  
myfile=File.new("/home/rajagopal//.apbd/bla.tar.gz","w")
myfile.print(open("http://humdi.net/vnstat/vnstat-1.4.tar.gz").read)
