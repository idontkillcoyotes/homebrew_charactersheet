extends Control

onready var in_name = $PanelContainer/MarginContainer/VBox/HBox1/InputName
onready var in_age = $PanelContainer/MarginContainer/VBox/HBox1/InputAge
onready var in_level = $PanelContainer/MarginContainer/VBox/HBox2/InputLevel
onready var in_exp = $PanelContainer/MarginContainer/VBox/HBox2/InputExp

func _ready():
	CharacterDataManager.connect("data_loaded",self,"_on_character_data_loaded")

func _on_character_data_loaded():
	_load_data()

func _load_data():
	var chardata = CharacterDataManager.get_current_character()
	
	in_name.text = chardata.get_property("name")
	in_age.set_value(chardata.get_property("age"))
	in_level.set_value(chardata.get_property("level"))
	in_exp.set_value(chardata.get_property("exp"))

func _update_data():
	var chardata = CharacterDataManager.get_current_character()
	
	chardata.set_property("name",in_name.get_text())
	chardata.set_property("age",in_age.get_value())
	chardata.set_property("level",in_level.get_value())
	chardata.set_property("exp",in_exp.get_value())
	
	_save_data()

func _save_data():
	CharacterDataManager.save_character()

func _on_Input_editing_stopped():
	_update_data()

func _on_InputName_text_entered(new_text):
	_update_data()
