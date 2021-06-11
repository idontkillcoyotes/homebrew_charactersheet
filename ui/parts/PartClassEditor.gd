extends PanelContainer

signal closed
signal data_saved
signal button_abilities_pressed(data)

onready var in_name = $VBoxContainer/MarginContainer/VBoxContainer/Box1/InputName
onready var in_desc = $VBoxContainer/MarginContainer/VBoxContainer/Box2/InputDescription
onready var in_attribute = $VBoxContainer/MarginContainer/VBoxContainer/Box3/AttributePicker
onready var in_bonus_attr = $VBoxContainer/MarginContainer/VBoxContainer/Box3/InputBonusAttribute
onready var in_prof = $VBoxContainer/MarginContainer/VBoxContainer/Box4/InputProf
onready var in_PR = $VBoxContainer/MarginContainer/VBoxContainer/Box6/InputPRes
onready var in_MR = $VBoxContainer/MarginContainer/VBoxContainer/Box6/InputMRes
onready var in_dice = $VBoxContainer/MarginContainer/VBoxContainer/Box4/InputDice

var classdata : CharacterClassData = null
var file_name : String = ""

func _load(data:CharacterClassData,file:String):
	classdata = data
	file_name = file
	_load_data()
	self.show()

func _new():
	classdata = CharacterClassData.new()
	file_name = "class_" + str(OS.get_unix_time()) + ".tres"
	_load_data()
	in_attribute.set_selected_attribute(0)
	self.show()

func _ready():
	self.hide()

func _load_data():
	in_name.set_text(classdata.name)
	in_desc.set_text(classdata.description)
	in_attribute.set_selected_attribute(classdata.main_attribute)
	in_bonus_attr.set_value(classdata.main_attribute_bonus)
	in_prof.set_value(classdata.base_bonus_proficiency)
	in_PR.set_value(classdata.base_physical_resistance)
	in_MR.set_value(classdata.base_magical_resistance)
	in_dice.set_value(classdata.hit_dice_sides)

func _update_data():
	classdata.name = in_name.get_text()
	classdata.description = in_desc.get_text()
	classdata.main_attribute = in_attribute.get_selected_attribute()
	classdata.main_attribute_bonus = int(in_bonus_attr.get_value())
	classdata.base_bonus_proficiency = int(in_prof.get_value())
	classdata.base_physical_resistance = int(in_PR.get_value())
	classdata.base_magical_resistance = int(in_MR.get_value())
	classdata.hit_dice_sides = int(in_dice.get_value())

func _save():
	var path = GameDataManager.classes_path+"/"+file_name
	if ResourceSaver.save(path,classdata) != OK:
		print("There was an error trying to save the class")
		return ERR_CANT_CREATE
	else:
		print("Class saved as: ",file_name)
		emit_signal("data_saved")
		return OK

func _on_ButtonSave_pressed():
	_update_data()
	_save()
	self.hide()
	emit_signal("closed")

func _on_ButtonCancel_pressed():
	self.hide()
	emit_signal("closed")
func _on_ButtonAbilities_pressed():
	emit_signal("button_abilities_pressed",classdata)

# Connected from Explorer
func _on_Explorer_edit(data,filename):
	_load(data,filename)
func _on_Explorer_new():
	_new()
