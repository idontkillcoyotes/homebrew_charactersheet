extends Control

onready var in_current = $PanelContainer/VBoxContainer/InputCurrent
onready var in_max = $PanelContainer/VBoxContainer/InputMax


func _ready():
	CharacterDataManager.connect("data_loaded",self,"_on_characer_data_loaded")

func _on_character_data_loaded():
	_load()

func _load():
	var chardata = CharacterDataManager.get_current_character()
	
	in_current.set_value(chardata.get_property("current_hp"))
	in_max.set_value(chardata.get_property("max_hp"))

func _update_data():
	_validate()
	
	var chardata = CharacterDataManager.get_current_character()
	
	chardata.set_property("current_hp",in_current.get_value())
	chardata.set_property("max_hp",in_max.get_value())
	
	CharacterDataManager.save_character()

func _validate():
	var maxhp : int = in_max.get_value()
	var current : int = in_current.get_value()
	
	if current > maxhp:
		current = maxhp
		in_current.set_value(current)


func _on_InputCurrent_editing_stopped():
	_update_data()

func _on_InputMax_editing_stopped():
	_update_data()
