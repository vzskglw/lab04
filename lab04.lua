#!/bin/lua5.3
lgi = require 'lgi'
gtk = lgi.Gtk
pixbuf = lgi.GdkPixbuf.Pixbuf
gtk.init()


bld = gtk.Builder()
bld:add_from_file('lab04.glade')
ui = bld.objects

ui.wnd.title = 'lab-04-zhuravleva'
ui.wnd.on_destroy = gtk.main_quit

names= {}
values= {}

function ui.btnSave:on_clicked(...)
--file = "lab04"--file name to write 

for key,value in ipairs(names) do
print(key,value)
end
--fw = io.open(file, 'w')--"a"
--for i=1,#names do

--string = names[i]..values[i]
--fw:write(string.."\n")
--end
--fw:close()
end

function ui.btnLoad:on_clicked(...)
  local file = "lab04"
	--ui.items:remove(iter)

for line in io.lines(file) do
	for s in string.gmatch(line, "%a+") do
	table.insert(names,s)
	end
	for n in string.gmatch(line, "%d+") do
	table.insert(values,n)
	end
end

for k=1,#names do
name = names[k]
value = values[k]
img ='img-'..name..'.png'
px = pixbuf.new_from_file(img)
i = ui.items:append()
ui.items[i] = {[1] = name, [2] = value, [3] = px}
end

--print(table.concat(values,","))
end

function ui.btnAdd:on_clicked(...)
	name = ui.eName.text
	value = tonumber(ui.eValue.text)
	img ='img-'..ui.eImg.text..'.png'
--path = path:append('.png')
	px = pixbuf.new_from_file(img)
	i = ui.items:append()
	ui.items[i] = {[1] = name, [2] = value, [3] = px}
table.insert(names, name)
table.insert(values, value)
end

function ui.btnDel:on_clicked(...)
model, iter = ui.tree:get_selected()
--print(tostring(ui.items:get_value(iter,1)))
	ui.items:remove(iter)
print(model:get_value(iter,2))

--table.remove(names, iter)
--table.remove(values, iter)
	--print(ui.items:get_selection())
--liststore:get_iter_first
	--ui.items:remove(items:get_iter_first())
	--ui.items[i] = {[1] = name, [2] = value, [3] = px}
end

function ui.tree:on_changed(...)
	model, iter = ui.tree:get_selected()
end

rdr_txt = gtk.CellRendererText {}
rdr_px = gtk.CellRendererPixbuf {}

c1 = gtk.TreeViewColumn { title = 'Name',  { rdr_txt, { text = 1   } } }
c2 = gtk.TreeViewColumn { title = 'Value', { rdr_txt, { text = 2   } } }
c3 = gtk.TreeViewColumn { title = 'Image', { rdr_px,  { pixbuf = 3 } } }

ui.list:append_column(c1)
ui.list:append_column(c2)
ui.list:append_column(c3)

ui.wnd:show_all()
gtk.main()
