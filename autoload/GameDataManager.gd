extends Node

const classes_path := "user://gamedata/classes"
const items_path := "user://gamedata/items"
const characters_path := "user://user/characters"

enum ATTRIBUTES {
	FUERZA,
	AGILIDAD,
	INTELIGENCIA,
	ASTUCIA,
	CARISMA
}

const abilities : Dictionary = {
	"Agarrar persona":ATTRIBUTES.FUERZA,
	"Analizar muestra":ATTRIBUTES.INTELIGENCIA,
	"Atletismo":ATTRIBUTES.AGILIDAD,
	"Averiguar intenciones":ATTRIBUTES.ASTUCIA,
	"Destruir":ATTRIBUTES.FUERZA,
	"Disfrazarse":ATTRIBUTES.CARISMA,
	"Historia":ATTRIBUTES.INTELIGENCIA,
	"Interpretacion":ATTRIBUTES.CARISMA,
	"Investigacion":ATTRIBUTES.ASTUCIA,
	"Intimidar":ATTRIBUTES.CARISMA,
	"Juego de manos":ATTRIBUTES.AGILIDAD,
	"Linguistica":ATTRIBUTES.INTELIGENCIA,
	"Manualidades":ATTRIBUTES.ASTUCIA,
	"Medicina":ATTRIBUTES.INTELIGENCIA,
	"Mover grandes objetos":ATTRIBUTES.FUERZA,
	"Naturaleza":ATTRIBUTES.INTELIGENCIA,
	"Ocultarse":ATTRIBUTES.AGILIDAD,
	"Ocultismo":ATTRIBUTES.INTELIGENCIA,
	"Percepcion":ATTRIBUTES.ASTUCIA,
	"Persuasion":ATTRIBUTES.CARISMA,
	"Sigilo":ATTRIBUTES.AGILIDAD,
	"Trepar":ATTRIBUTES.FUERZA,
	"Tumbar":ATTRIBUTES.FUERZA
}

var classes : Array = []

func _ready():
	_load_classes()

func update_classes():
	_load_classes()
	
func get_classes()->Array:
	return classes

func get_abilities()->Dictionary:
	return abilities

func get_class_by_name(_name:String)->CharacterClassData:
	var to_return = null
	for c in classes:
		if c.name == _name:
			to_return = c
	return to_return

func get_attributes()->Dictionary:
	return {
		"Fuerza":0,
		"Agilidad":1,
		"Inteligencia":2,
		"Astucia":3,
		"Carisma":4,
	}
func get_attribute_by_id(id:int)->String:
	match id:
		ATTRIBUTES.FUERZA: return "Fuerza"
		ATTRIBUTES.AGILIDAD: return "Agilidad"
		ATTRIBUTES.INTELIGENCIA: return "Inteligencia"
		ATTRIBUTES.ASTUCIA: return "Astucia"
		ATTRIBUTES.CARISMA: return "Carisma"
	return "Fuerza"


func _create_directories():
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir_recursive(classes_path)
	dir.make_dir_recursive(items_path)
	dir.make_dir_recursive(characters_path)

func _load_classes():
	classes = []
	var dir = Directory.new()
	var path = GameDataManager.classes_path
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var file_path = path+"/"+file_name
				var res = ResourceLoader.load(file_path)
				if res != null:
					classes.push_back(res)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the game classes folder.")
		_create_directories()
		return ERR_CANT_OPEN
