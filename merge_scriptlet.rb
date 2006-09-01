#!/usr/bin/env ruby

require 'rubygems'
require 'xml/libxml'
require 'Classes.rb'

def find_node(node,name)
	if node.find(name)!=nil
		return node
	else
		if node.child?
			child_node = node.child
			find_node(child_node,name)
			begin
				child_node=child_node.next
				return find_node(child_node,name)
			end while child_node.next?
		end
	end
end

def patch_scriptlet(desc_file,scriptlet_file)
	xmldesc = XML::Document.file(desc_file)
	xmlscript = XML::Document.file(scriptlet_file)
	scriptroot = xmlscript.root
	descroot = xmldesc.root
	if scriptroot.child?
	if_nodeset = scriptroot.find('if')
	if_nodeset.each do |node_item|
	puts node_item['distro']==/#{Pkgvars.get_distro}/i
		if node_item['distro']==/#{Pkgvars.get_distro}/i && node_item['version']==nil || node_item['distro']==/#{Pkgvars.get_distro}/i && node_item['version']==Pkgvars.get_version || node_item['distro']==nil && node_item['version']==Pkgvars.get_version
			find_node(descroot,node_item.name) << new_node = XML::Node.new(node_item.name)
			new_node << node_item.content
		end
	end
	end
end

desc_file = $*[0]
scriptlet_file = $*[1]
patch_scriptlet(desc_file,scriptlet_file)
