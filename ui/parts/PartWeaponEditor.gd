extends PanelContainer

signal closed
signal data_saved

var file_name : String = ""

var itemdata : ItemWeapon = null

onready var in_name = $VBoxContainer/Contents/VBoxContainer/Box1/InputName
onready var in_desc = $VBoxContainer/Contents/VBoxContainer/Box2/InputDescription
onready var in_class = $VBoxContainer/Contents/VBoxContainer/Box3/InputClass
onready var in_attributes = $VBoxContainer/Contents/VBoxContainer/Box4/VBoxContainer/InputAttributes
onready var in_attack_range = $VBoxContainer/Contents/VBoxContainer/Box5/InputRange
onready var in_attack_type = $VBoxContainer/Contents/VBoxContainer/Box5/InputAttackType
onready var in_damage_type = $VBoxContainer/Contents/VBoxContainer/Box6/InputDamageType
onready var in_damage_dice_sides = $VBoxContainer/Contents/VBoxContainer/Box6/InputDiceSides
onready var in_damage_dice_quantity = $VBoxContainer/Contents/VBoxContainer/Box6/InputDiceQuantity


func _ready():
	self.hide()

func _load_item(data:ItemWeapon,file:String):
	itemdata = data
	file_name = file
	_load_data()
	self.show()

func _new_item():
	itemdata = ItemWeapon.new()
	file_name = "item_" + str(OS.get_unix_time()) + ".tres"
	_load_data()
	self.show()

func _load_data():
	in_name.set_text(itemdata.get_property("name"))
	in_desc.set_text(itemdata.get_property("description"))
	in_class.set_text(itemdata.get_property("class"))
	in_attack_type.select(itemdata.get_property("attack_type"))
	in_attack_range.set_value(itemdata.get_property("attack_range"))
	in_damage_type.set_text(itemdata.get_property("damage_type"))
	in_damage_dice_sides.set_value(itemdata.get_property("damage_dice_sides"))
	in_damage_dice_quantity.set_value(itemdata.get_property("damage_dice_quantity"))
	
	in_attributes.set_selected_attributes(itemdata.get_attack_roll_attributes())

func _update_data():
	itemdata.set_property("name",in_name.get_text())
	itemdata.set_property("description",in_desc.get_text())
	itemdata.set_property("class",in_class.get_text())
	itemdata.set_property("attack_type",in_attack_type.get_selected())
	itemdata.set_property("attack_range",in_attack_range.get_value())
	itemdata.set_property("damage_type",in_damage_type.get_text())
	itemdata.set_property("damage_dice_sides",in_damage_dice_sides.get_value())
	itemdata.set_property("damage_dice_quantity",in_damage_dice_quantity.get_value())
	
	var list = in_attributes.get_selected_attributes()
	for item in list:
		itemdata.add_attack_roll_attribute(item)
	

func _save_data():
	var path = GameDataManager.items_path + "/" + file_name
	if ResourceSaver.save(path,itemdata) != OK:
		print("There was an error trying to save the item")
		return ERR_CANT_CREATE
	else:
		print("Item saved as: ",file_name)
		emit_signal("data_saved")
		return OK

func _on_ButtonSave_pressed():
	_update_data()
	_save_data()
	self.hide()
	emit_signal("closed")

func _on_ButtonCancel_pressed():
	self.hide()
	emit_signal("closed")

# Connected from Explorer
func _on_Explorer_edit(data,file_name):
	_load_item(data,file_name)
func _on_Explorer_new():
	_new_item()
