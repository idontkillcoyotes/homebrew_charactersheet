extends VBoxContainer

onready var in_name := $HBox1/InputName
onready var in_age := $HBox1/InputAge
onready var in_level := $HBox2/InputLevel
onready var in_exp := $HBox2/InputExp

func _ready():
	_load_data()

func _load_data():
	var chardata = CharacterDataManager.get_current_character()
	
	in_name.text = chardata.character_name
	in_age.set_value(chardata.character_age)
	in_level.set_value(chardata.character_level)
	in_exp.set_value(chardata.character_exp)

func _update_data():
	var chardata = CharacterDataManager.get_current_character()
	
	chardata.character_name = in_name.text
	chardata.character_age = in_age.get_value()
	chardata.character_level = in_level.get_value()
	chardata.character_exp = in_exp.get_value()
	
	_save_data()

func _save_data():
	CharacterDataManager.save_character()

func _on_InputExp_editing_stopped():
	_update_data()

func _on_InputLevel_editing_stopped():
	_update_data()

func _on_InputAge_editing_stopped():
	_update_data()

func _on_InputName_text_entered(new_text):
	_update_data()

func _on_InputName_focus_exited():
	_update_data()
