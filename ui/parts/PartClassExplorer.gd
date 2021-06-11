extends PanelContainer

signal closed
signal edit(data,filename)
signal new

onready var btn_new = $VBoxContainer/Buttons/Box/ButtonNew
onready var btn_edit = $VBoxContainer/Buttons/Box/ButtonEdit
onready var btn_delete =$VBoxContainer/Buttons/Box/ButtonDelete
onready var class_list = $VBoxContainer/MarginContainer2/ClassesList

var selected : Dictionary

func open():
	self.show()
	class_list.reload()

func _ready():
	self.hide()
	pass

func _set_disable_buttons(value:bool):
	btn_delete.disabled=value
	btn_edit.disabled=value

func _on_ButtonNew_pressed():
	_set_disable_buttons(true)
	emit_signal("new")

func _on_ButtonEdit_pressed():
	_set_disable_buttons(true)
	var data = selected["data"]
	var file_name = selected["file_name"]
	emit_signal("edit",data,file_name)

func _on_ButtonDelete_pressed():
	#TODO: delete items
	pass

func _on_Editor_data_saved():
	class_list.reload()
	_set_disable_buttons(true)

func _on_Editor_closed():
	_set_disable_buttons(true)
	btn_new.disabled=false

func _on_ButtonClose_pressed():
	self.hide()
	emit_signal("explorer_closed")

func _on_ClassesList_selected_item(index):
	selected = GameDataManager.get_class_at(index)
	_set_disable_buttons(false)

func _on_ClassesList_selected_nothing():
	selected = {}
	_set_disable_buttons(true)
