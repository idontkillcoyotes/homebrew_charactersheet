extends Control

export (bool) var rolleable = false setget set_rolleable,is_rolleable
export (bool) var editable = false setget set_editable,is_editable
export (String) var display_name = "Stat" setget set_display_name,get_display_name
export (String) var stat_name = "stat_name" setget set_stat_name,get_stat_name

onready var button_name = $MarginContainer/VBoxContainer/ButtonName
onready var input = $MarginContainer/VBoxContainer/Input

var value : int = 0

func _ready():
	CharacterDataManager.connect("data_updated",self,"_on_data_updated")
	button_name.disabled = not rolleable
	input.editable = editable
	button_name.text = display_name
	CharacterDataManager.connect("data_loaded",self,"_on_character_data_loaded")

func _on_character_data_loaded():
	_load_data()

func get_value()->int:
	return value
func set_display_name(val:String):
	display_name = val
func get_display_name()->String:
	return display_name

func set_stat_name(name:String):
	stat_name = name

func get_stat_name()->String:
	return stat_name

func set_rolleable(value:bool):
	rolleable = value
	if button_name!= null:
		button_name.disabled = not value
func is_rolleable()->bool:
	return rolleable

func set_editable(value:bool):
	editable = value
	if input != null:
		input.editable = value
func is_editable()->bool:
	return editable

func _save_data():
	var chardata = CharacterDataManager.get_current_character()
	
	var value = input.get_value()
	
	chardata.set_property(stat_name,value)
	
	CharacterDataManager.save_character()

func _load_data():
	var chardata = CharacterDataManager.get_current_character()
		
	var value = chardata.get_property(stat_name)
	
	input.set_value(value)


func _on_data_updated():
	_load_data()

func _roll():
	pass


func _on_NumberImput_value_changed(_value:int):
	if editable:
		_save_data()
func _on_ButtonName_pressed():
	if rolleable:
		_roll()
