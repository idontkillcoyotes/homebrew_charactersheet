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
	"agarrar_persona":ATTRIBUTES.FUERZA,
	"analizar_muestra":ATTRIBUTES.INTELIGENCIA,
	"atletismo":ATTRIBUTES.AGILIDAD,
	"averiguar_intenciones":ATTRIBUTES.ASTUCIA,
	"destruir":ATTRIBUTES.FUERZA,
	"mover_grandes_objetos":ATTRIBUTES.FUERZA,
	"trepar":ATTRIBUTES.FUERZA,
	"tumbar":ATTRIBUTES.FUERZA,
	"juego_de_manos":ATTRIBUTES.AGILIDAD,
	"ocultarse":ATTRIBUTES.AGILIDAD,
	"sigilo":ATTRIBUTES.AGILIDAD,
	"historia":ATTRIBUTES.INTELIGENCIA,
	"linguistica":ATTRIBUTES.INTELIGENCIA,
	"medicina":ATTRIBUTES.INTELIGENCIA,
	"naturaleza":ATTRIBUTES.INTELIGENCIA,
	"ocultismo":ATTRIBUTES.INTELIGENCIA,
	"investigacion":ATTRIBUTES.ASTUCIA,
	"manualidades":ATTRIBUTES.ASTUCIA,
	"percepcion":ATTRIBUTES.ASTUCIA,
	"disfrazarse":ATTRIBUTES.CARISMA,
	"interpretacion":ATTRIBUTES.CARISMA,
	"intimidar":ATTRIBUTES.CARISMA,
	"persuasion":ATTRIBUTES.CARISMA
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
		return ERR_CANT_OPEN
