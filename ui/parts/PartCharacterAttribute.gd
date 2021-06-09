extends Control
class_name Attribute

signal data_changed

export (bool) var rolleable = true
export (String) var atr_name = "atributo"
var mod : int = 0

onready var label_mod = $MarginContainer/VBoxContainer/LabelMod
onready var button_name = $MarginContainer/VBoxContainer/ButtonName
onready var input = $MarginContainer/VBoxContainer/Input

func _ready():
	button_name.text = atr_name
	button_name.disabled = not rolleable
	_calculate()

func set_rolleable(value:bool):
	rolleable = value
	button_name.disabled = not rolleable
	
func set_input_editable(value:bool):
	input.set_editable(value)

func set_attrname(value:String):
	atr_name = value
	button_name.text = atr_name
func get_attrname()->String:
	return atr_name

func set_value(value:int):
	input.set_value(value)
	_calculate()

func get_mod()->int:
	return mod

func _calculate():
	var value = input.get_value()
	mod = int((value-10)/2)
	if mod>=0:
		label_mod.text = "+"+str(mod)
	else:
		label_mod.text = str(mod)

func _update_data():
	var chardata = CharacterDataManager.get_current_character()
	chardata.attributes[atr_name] = input.get_value()
	CharacterDataManager.save_character()

func _on_Input_editing_stopped():
	_calculate()
	_update_data()

func _on_Input_value_changed(value):
	_calculate()
