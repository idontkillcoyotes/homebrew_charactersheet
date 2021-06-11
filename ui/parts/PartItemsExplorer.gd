extends PanelContainer

signal closed
signal new_weapon
signal new_equipable
signal edit_weapon(data,file_name)
signal edit_equipable(data,file_name)

onready var btn_new_weapon = $VBoxContainer/Buttons/VBoxContainer/Box2/ButtonNewWeapon
onready var btn_new_equipable = $VBoxContainer/Buttons/VBoxContainer/Box2/ButtonNewEquipable
onready var btn_edit = $VBoxContainer/Buttons/VBoxContainer/Box1/ButtonEdit
onready var btn_delete = $VBoxContainer/Buttons/VBoxContainer/Box1/ButtonDelete
onready var item_list = $VBoxContainer/Contents/ItemsList

var selected : Dictionary

func open():
	self.show()
	item_list.reload()

func _ready():
	_set_disable_buttons(true)
	self.hide()

func _set_disable_buttons(value:bool):
	btn_delete.disabled=value
	btn_edit.disabled=value

func _on_ButtonClose_pressed():
	self.hide()
	emit_signal("closed")

func _on_ItemsList_selected_item(index):
	selected = GameDataManager.get_item_at(index)
	_set_disable_buttons(false)

func _on_ItemsList_selected_nothing():
	selected = {}
	_set_disable_buttons(true)

func _on_Editor_data_saved():
	item_list.reload()
func _on_Editor_closed():
	_set_disable_buttons(true)
	
func _on_ButtonDelete_pressed():
	#TODO: delete
	pass # Replace with function body.

func _on_ButtonEdit_pressed():
	var data = selected["data"]
	var file = selected["file_name"]
	if data is ItemWeapon:
		emit_signal("edit_weapon",data,file)
	elif data is ItemEquipable:
		emit_signal("edit_equipable",data,file)

func _on_ButtonNewEquipable_pressed():
	_set_disable_buttons(true)
	emit_signal("new_equipable")

func _on_ButtonNewWeapon_pressed():
	_set_disable_buttons(true)
	emit_signal("new_weapon")
