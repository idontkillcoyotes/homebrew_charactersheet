extends Node

signal data_updated
signal data_saved
signal data_loaded

var current_character : CharacterData = null
var current_character_file_name : String = ""

var characters : Array = []

func _ready():
	_load()

func _load():
	characters = []
	var dir = Directory.new()
	var path = GameDataManager.characters_path
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var file_path = path+"/"+file_name
				var res = ResourceLoader.load(file_path)
				if res != null:
					var entry : Dictionary ={
						"data": res,
						"file_name":file_name,
					}
					characters.push_back(entry)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the user characters folder.")
		return ERR_CANT_OPEN


func update_characters():
	_load()

func get_characters()->Array:
	return characters

func get_current_character()->CharacterData:
	return current_character

func load_character(index:int):
	var entry : Dictionary = characters[index]
	_set_current_character(entry["data"],entry["file_name"])

func save_character():
	var path = GameDataManager.characters_path +"/"+current_character_file_name
	if ResourceSaver.save(path,current_character) != OK:
		print("Error saving character data.")
		return ERR_FILE_CANT_WRITE
	else:
		#print("Character data saved in file: ",current_character_file_name)
		emit_signal("data_saved")
		update_characters()
		return OK

func _set_current_character(data:CharacterData,file_name:String):
	current_character = data
	current_character_file_name = file_name
	current_character.connect("changed",self,"_on_characterdata_changed")
	emit_signal("data_loaded")

func new_character():
	if current_character != null:
		save_character()
	
	var file_name : String = "char_"+str(OS.get_unix_time())+".tres"
	_set_current_character(CharacterData.new(),file_name)

func _on_characterdata_changed():
	emit_signal("data_updated")
