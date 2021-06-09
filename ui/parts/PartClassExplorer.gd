extends PanelContainer

signal new_class
signal edit_class(classdata)

onready var btn_new = $VBoxContainer/Buttons/Box/ButtonNew
onready var btn_edit = $VBoxContainer/Buttons/Box/ButtonEdit
onready var btn_delete =$VBoxContainer/Buttons/Box/ButtonDelete
onready var class_list = $VBoxContainer/MarginContainer2/ClassesList

func _ready():
	btn_edit.disabled=true
	btn_delete.disabled=true
	btn_new.disabled=false

func _set_disable_buttons(value:bool):
	btn_delete.disabled=value
	btn_edit.disabled=value
	btn_new.disabled=value

func _on_ButtonNew_pressed():
	_set_disable_buttons(true)
	emit_signal("new_class")

func _on_ButtonEdit_pressed():
	_set_disable_buttons(true)
	var classdata : CharacterClassData = class_list.get_selected_class()
	emit_signal("edit_class",classdata)

func _on_ButtonDelete_pressed():
	pass # Replace with function body.

func _on_ClassesList_class_deselected():
	_set_disable_buttons(true)
	btn_new.disabled=false

func _on_ClassesList_class_selected(_class_data):
	_set_disable_buttons(false)

func _on_ClassEditor_class_saved():
	class_list.reload()

func _on_ClassEditor_editor_closed():
	_set_disable_buttons(true)
	btn_new.disabled=false
