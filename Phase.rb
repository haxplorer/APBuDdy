############################################################################
#    Copyright (C) 2006 by Rajagopal N   #
#    rajagopal.developer@gmail.com   #
#                                                                          #
#    This program is free software; you can redistribute it and#or modify  #
#    it under the terms of the GNU General Public License as published by  #
#    the Free Software Foundation; either version 2 of the License, or     #
#    (at your option) any later version.                                   #
#                                                                          #
#    This program is distributed in the hope that it will be useful,       #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#    GNU General Public License for more details.                          #
#                                                                          #
#    You should have received a copy of the GNU General Public License     #
#    along with this program; if not, write to the                         #
#    Free Software Foundation, Inc.,                                       #
#    59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
############################################################################

#!/usr/bin/env ruby

class Phase

	@@phase_queue = Array.new

	def initialize(name,steps,enabled=1)
		@name=name
		@steps=steps
		@enabled=enabled
	end
	def Phase.phase_empty(name)
		temp_phase=new(name,Array.new,0)
		@@phase_queue.push(temp_phase)
	end
	def Phase.phase_add_after(name,steps,name_prev,enabled=1)
                temp_phase=new(name,steps,enabled)
                @@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.name==name_prev
                                @@phase_queue.insert(index,temp_phase)
                        end
                end
	end
        def Phase.phase_add_before(name,steps,name_next,enabled=1)
                temp_phase=new(name,steps,enabled)
                pos=0
                @@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.name==name_next
                              pos=index-1  
                        end
                end
                @@phase_queue.insert(pos,temp_phase)
	end
	def Phase.phase_empty_after(name,name_prev)
		phase_add_after(name,Array.new,0,name_prev)
	end
	def Phase.phase_empty_before(name,name_next)
		phase_add_before(name,Array.new,0,name_next)
	end
	def enable
		@enabled=1
	end
	def disable
		@enabled=0
	end
	def move_to_before(name_next)
                temp_phase=self
                @@phase_queue.delete_if{|item| item.name==self.name}
		@@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.name==name_next
                              pos=index-1
                        end
                end
		@@phase_queue.insert(pos,temp_phase)
	end
	def move_to_after(name_prev)
                temp_phase=self
                @@phase_queue.delete_if{|item| item.name==self.name}
                @@phase_queue.each_with_index do |phase_item,index|
                        if phase_item.name==name_prev
                                @@phase_queue.insert(index,temp_phase)
                        end
                end
	end
end

