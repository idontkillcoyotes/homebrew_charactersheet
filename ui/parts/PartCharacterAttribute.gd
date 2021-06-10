extends Control
class_name Attribute


export (bool) var rolleable = true setget set_rolleable,is_rolleable
export (bool) var editable = true setget set_editable,is_editable
export (String) var display_name = "atributo" setget set_display_name
export (String) var character_stat_name = "stat_name" setget set_character_stat_name

var mod : int = 0

onready var label_mod = $MarginContainer/VBoxContainer/LabelMod
onready var button_name = $MarginContainer/VBoxContainer/ButtonName
onready var input = $MarginContainer/VBoxContainer/Input

func _ready():
	button_name.text = display_name
	button_name.disabled = not rolleable
	input.editable = editable
	_calculate()

func load_data():
	var chardata = CharacterDataManager.get_current_character()
	_set_value(chardata.get_attribute(character_stat_name))

func set_rolleable(value:bool):
	rolleable = value
	if button_name != null:
		button_name.disabled = not rolleable
func is_rolleable()->bool:
	return rolleable
	
func set_editable(value:bool):
	editable = value
	if input != null:
		input.set_editable(editable)
func is_editable()->bool:
	return editable

func set_character_stat_name(name:String):
	character_stat_name = name

func set_display_name(value:String):
	display_name = value
	if button_name != null:
		button_name.text = display_name
func get_display_name()->String:
	return display_name

func get_mod()->int:
	return mod



func _set_value(value:int):
	input.set_value(value)
	_calculate()

func _calculate():
	var value = input.get_value()
	mod = int((value-10)/2)
	if mod>=0:
		label_mod.text = "+"+str(mod)
	else:
		label_mod.text = str(mod)

func _update_data():
	var chardata = CharacterDataManager.get_current_character()
	
	chardata.set_attribute(character_stat_name,input.get_value())
	
	CharacterDataManager.save_character()

func _on_Input_editing_stopped():
	_calculate()
	_update_data()

func _on_Input_value_changed(value):
	_calculate()
