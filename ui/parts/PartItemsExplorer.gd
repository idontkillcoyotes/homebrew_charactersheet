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
	_set_disable_buttons(true,false)
	item_list.reload()

func close():
	self.hide()
	emit_signal("closed")

func _ready():
	_set_disable_buttons(true,false)
	self.hide()

func _set_disable_buttons(val1:bool,val2:bool):
	btn_delete.disabled=val1
	btn_edit.disabled=val1
	btn_new_equipable.disabled=val2
	btn_new_weapon.disabled=val2

func _on_ButtonClose_pressed():
	close()

func _on_ItemsList_selected_item(index):
	selected = GameDataManager.get_item_at(index)
	_set_disable_buttons(false,false)

func _on_ItemsList_selected_nothing():
	selected = {}
	_set_disable_buttons(true,false)

func _on_Editor_data_saved():
	item_list.reload()
func _on_Editor_closed():
	_set_disable_buttons(true,false)
	
func _on_ButtonDelete_pressed():
	var error = GameDataManager.delete_file(selected["file_name"],GameDataManager.items_path)
	if error != OK:
		print("There was an error while trying to delete an item file.")
	else:
		item_list.reload()

func _on_ButtonEdit_pressed():
	_set_disable_buttons(true,true)
	
	var data = selected["data"]
	var file = selected["file_name"]
	if data is ItemWeapon:
		emit_signal("edit_weapon",data,file)
	elif data is ItemEquipable:
		emit_signal("edit_equipable",data,file)

func _on_ButtonNewEquipable_pressed():
	_set_disable_buttons(true,true)
	emit_signal("new_equipable")

func _on_ButtonNewWeapon_pressed():
	_set_disable_buttons(true,true)
	emit_signal("new_weapon")

func _on_gui_input(event: InputEvent):
	if event.is_action_released("ui_cancel"):
		close()
