require 'rubygems'
require 'mechanize'

package_name=ARGV[0]
agent = WWW::Mechanize.new {|a| a.log = Logger.new(STDERR) }
page = agent.get("http://prdownloads.sourceforge.net/#{package_name}")
puts page.body
