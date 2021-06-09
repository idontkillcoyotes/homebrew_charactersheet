extends PanelContainer

signal editor_closed
signal class_saved

var classdata : CharacterClassData = null

onready var in_name = $VBoxContainer/MarginContainer/VBoxContainer/Box1/InputName
onready var in_desc = $VBoxContainer/MarginContainer/VBoxContainer/Box2/InputDescription
onready var in_attribute = $VBoxContainer/MarginContainer/VBoxContainer/Box3/AttributePicker
onready var in_bonus_attr = $VBoxContainer/MarginContainer/VBoxContainer/Box3/InputBonusAttribute
onready var in_prof = $VBoxContainer/MarginContainer/VBoxContainer/Box4/InputProf
onready var in_PR = $VBoxContainer/MarginContainer/VBoxContainer/Box6/InputPRes
onready var in_MR = $VBoxContainer/MarginContainer/VBoxContainer/Box6/InputMRes
onready var in_dice = $VBoxContainer/MarginContainer/VBoxContainer/Box4/InputDice

func _ready():
	self.hide()

func load_class(data:CharacterClassData):
	self.classdata = data
	_load_data()
	self.show()

func _load_data():
	in_name.text = classdata.name
	in_desc.text = classdata.description
	in_attribute.set_selected_attribute(classdata.main_attribute)
	in_bonus_attr.set_value(classdata.main_attribute_bonus)
	in_prof.set_value(classdata.base_bonus_proficiency)
	in_PR.set_value(classdata.base_physical_resistance)
	in_MR.set_value(classdata.base_magical_resistance)
	in_dice.set_value(classdata.hit_dice_sides)

func new_class():
	classdata = CharacterClassData.new()
	_load_data()
	self.show()

func save_class():
	classdata.name = in_name.get_text()
	classdata.description = in_desc.get_text()
	classdata.main_attribute = in_attribute.get_selected_attribute()
	classdata.main_attribute_bonus = int(in_bonus_attr.get_value())
	classdata.base_bonus_proficiency = int(in_prof.get_value())
	classdata.base_physical_resistance = int(in_PR.get_value())
	classdata.base_magical_resistance = int(in_MR.get_value())
	classdata.hit_dice_sides = int(in_dice.get_value())
	
	#abilities
	var path = GameDataManager.classes_path+"/"+classdata.name+".res"
	if ResourceSaver.save(path,classdata) != OK:
		print("There was an error trying to save the class")

func _on_ButtonSave_pressed():
	save_class()
	emit_signal("class_saved")
	self.hide()
	emit_signal("editor_closed")

func _on_ButtonCancel_pressed():
	self.hide()
	emit_signal("editor_closed")

func _on_ClassExplorer_new_class():
	new_class()
	in_name.editable = true
	self.show()

func _on_ClassExplorer_edit_class(classdata):
	load_class(classdata)
	in_name.editable = false
	self.show()
