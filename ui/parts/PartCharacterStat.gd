extends Control

export (bool) var rolleable = false setget set_rolleable,is_rolleable
export (bool) var editable = true setget set_editable,is_editable
export (String) var display_name = "Stat" setget set_display_name,get_display_name
export (String) var charactersheet_stat_name = "stat_name" setget set_charactersheet_stat_name,get_charactersheet_stat_name

onready var button_name = $MarginContainer/CenterContainer/VBoxContainer/ButtonName
onready var input = $MarginContainer/CenterContainer/VBoxContainer/NumberImput

var value : int = 0

func _ready():
	button_name.disabled = not rolleable
	input.editable = editable
	button_name.text = display_name

func get_value()->int:
	return value
func set_display_name(val:String):
	display_name = val
func get_display_name()->String:
	return display_name

func set_charactersheet_stat_name(name:String):
	charactersheet_stat_name = name
func get_charactersheet_stat_name()->String:
	return charactersheet_stat_name

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

func _calculate(_value:int):
	value = _value	
func _on_NumberImput_value_changed(_value:int):
	_calculate(_value)
func _on_ButtonName_pressed():
	pass
