extends Node

signal character_data_loaded
signal character_data_saved

var current_character : CharacterData = null
var current_character_path : String = ""
var current_character_file_name : String = ""

func _ready():
	load_character("oliver.tres")

func get_current_character()->CharacterData:
	return current_character

func get_current_character_file_name()->String:
	return current_character_file_name

func load_character(file_name:String):
	var path = GameDataManager.characters_path+"/"+file_name
	var data = ResourceLoader.load(path)
	if data == null:
		data = CharacterData.new()
	
	current_character = data
	current_character_file_name = file_name
	current_character_path = path
	emit_signal("character_data_loaded")

func save_character():
	if ResourceSaver.save(current_character_path,current_character) != OK:
		print("Error saving character sheet")
		return ERR_FILE_CANT_WRITE
	else:
		emit_signal("character_data_saved")

func new_character(file_name:String):
	save_character()
	current_character = CharacterData.new()
	current_character_file_name = file_name
	current_character_path = GameDataManager.characters_path+"/"+file_name
	emit_signal("character_data_loaded")
