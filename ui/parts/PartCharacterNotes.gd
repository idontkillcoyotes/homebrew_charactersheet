extends MarginContainer

onready var notes = $PanelContainer/MarginContainer/Notes

func _ready():
	CharacterDataManager.connect("data_loaded",self,"_on_character_data_loaded")

func _on_character_data_loaded():
	_load()

func _load():
	var chardata = CharacterDataManager.get_current_character()
	notes.set_text(chardata.get_property("notes"))

func _update_data():
	var chardata = CharacterDataManager.get_current_character()
	
	chardata.set_property("notes",notes.get_text())

func _save():
	CharacterDataManager.save_character()

func _on_Notes_text_changed():
	_update_data()
