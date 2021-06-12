extends PanelContainer
# Equipable editor

signal closed
signal data_saved

onready var in_name = $VBoxContainer/Contents/VBoxContainer/Box1/InputName
onready var in_desc = $VBoxContainer/Contents/VBoxContainer/Box2/InputDescription
onready var in_class = $VBoxContainer/Contents/VBoxContainer/Box3/InputClass
onready var in_slot = $VBoxContainer/Contents/VBoxContainer/Box5/InputSlotType
onready var in_sockets = $VBoxContainer/Contents/VBoxContainer/Box5/InputSockets
onready var in_PR = $VBoxContainer/Contents/VBoxContainer/Box6/InputPR
onready var in_MR = $VBoxContainer/Contents/VBoxContainer/Box6/InputMR
onready var in_ref = $VBoxContainer/Contents/VBoxContainer/Box7/InputReflex
onready var in_fort = $VBoxContainer/Contents/VBoxContainer/Box7/InputFortaleza


var file_name : String = ""
var itemdata : ItemEquipable = null

func close():
	self.hide()
	emit_signal("closed")

func _ready():
	self.hide()

func _load_item(data:ItemEquipable,file:String):
	itemdata = data
	file_name = file
	_load_data()
	self.show()

func _new_item():
	itemdata = ItemEquipable.new()
	file_name = "item_" + str(OS.get_unix_time()) + ".tres"
	_load_data()
	self.show()

func _load_data():
	in_name.set_text(itemdata.get_property("name"))
	in_desc.set_text(itemdata.get_property("description"))
	in_class.set_text(itemdata.get_property("class"))
	in_slot.select(itemdata.get_property("slot_type"))
	
	in_sockets.value = itemdata.get_property("sockets")
	in_PR.value = itemdata.get_property("physical_resistance")
	in_MR.value = itemdata.get_property("magical_resistance")
	in_ref.value = itemdata.get_property("mod_reflexes")
	in_fort.value = itemdata.get_property("mod_fortaleza")

func _update_data():
	itemdata.set_property("name",in_name.get_text())
	itemdata.set_property("description",in_desc.get_text())
	itemdata.set_property("class",in_class.get_text())
	itemdata.set_property("slot_type",in_slot.get_selected())
	
	var value
	value = in_sockets.get_value()
	itemdata.set_property("sockets",value)
	value = in_PR.get_value()
	itemdata.set_property("physical_resistance",value)
	value = in_MR.get_value()
	itemdata.set_property("magical_resistance",value)
	value = in_ref.get_value()
	itemdata.set_property("mod_reflexes",value)
	value = in_fort.get_value()
	itemdata.set_property("mod_fortaleza",value)

func _save_data():
	var path = GameDataManager.items_path + "/" + file_name
	if ResourceSaver.save(path,itemdata) != OK:
		print("There was an error trying to save the item")
		return ERR_CANT_CREATE
	else:
		print("Item (",itemdata.get_property("name"),") saved as: ",file_name)
		emit_signal("data_saved")
		return OK

func _on_ButtonSave_pressed():
	_update_data()
	_save_data()
	self.hide()
	emit_signal("closed")

func _on_ButtonCancel_pressed():
	close()

func _on_gui_input(event: InputEvent):
	if event.is_action_released("ui_cancel"):
		close()


# Connected from Explorer
func _on_Explorer_edit(data,file_name):
	_load_item(data,file_name)
func _on_Explorer_new():
	_new_item()

