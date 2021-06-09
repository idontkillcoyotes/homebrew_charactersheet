extends Resource
class_name CharacterSheetData

export var character_name : String = ""
export var character_age : int = 0
export var character_exp : int = 0
export var character_level : int = 0 setget set_level,get_level

export (Resource) var classdata setget set_class_data

# Calculated hp
export var resistance : int = 0

# Base number for all classes
export var base_reflexes : int = 8
export var base_fortaleza : int = 8

# Extra permanent bonuses
export var extra_physical_resistance : int = 0
export var extra_magical_resistance : int = 0
export var extra_reflexes_bonus : int = 0
export var extra_fortaleza_bonus : int = 0

# Attributes scores
export var attributes: Dictionary = {
	"Fuerza":0,
	"Agilidad":0,
	"Inteligencia":0,
	"Astucia":0,
	"Carisma":0
}

# Abilities level points
export var ability_points = {
	"fuerza":{
		"agarrar_persona":0,
		"destruir":0,
		"mover_grandes_objetos":0,
		"trepar":0,
		"tumbar":0
	},
	"agilidad":{
		"atletismo":0,
		"juego_de_manos":0,
		"ocultarse":0,
		"sigilo":0
	},
	"inteligencia":{
		"analizar_muestra":0,
		"historia":0,
		"linguistica":0,
		"medicina":0,
		"naturaleza":0,
		"ocultismo":0
	},
	"astucia":{
		"averiguar_intencion":0,
		"investigacion":0,
		"manualidades":0,
		"percepcion":0
	},
	"carisma":{
		"disfrazarse":0,
		"interpretacion":0,
		"intimidar":0,
		"persuasion":0
	}
}

export var inventory : Array = []

###################################################
# PUBLIC METHODS
###################################################

# Setters/Getters
func set_class_data(data:CharacterClassData):
	classdata = data
func set_level(value:int):
	character_level = value
func get_level()->int:
	return character_level


func add_item(item:Item):
	inventory.push_back(item)

func get_attribute_mod(attribute:String)->int:
	var name = attribute.to_lower()
	if attributes.has(name):
		return int((attributes[name]-10)/2)
	else:
		return 0

func set_attribute(attribute:String,value:int):
	var name = attribute.to_lower()
	if value>=0 and attributes.has(name):
		attributes[name] = value

func get_proficiency_bonus():
	if character_level <= 4:
		return classdata.base_bonus_proficiency
	else:
		var extra = int((character_level-2)/3)
		return (classdata.base_bonus_proficiency + extra)

func get_physical_resistance()->int:
	var value = classdata.base_physical_resistance
	value += _get_equipped_PF_bonus()
	value += get_attribute_mod("agilidad")
	value += extra_physical_resistance
	return value

func get_magical_resistance()->int:
	var value = classdata.base_magical_resistance
	value += _get_equipped_MF_bonus()
	value += extra_magical_resistance
	return value

func get_reflexes()->int:
	var value = base_reflexes
	value += get_attribute_mod("agilidad")
	value += get_proficiency_bonus()
	value += _get_equipped_REF_bonus()
	value += extra_reflexes_bonus
	return value

func get_fortaleza()->int:
	var value = base_fortaleza
	value += get_attribute_mod("fuerza")
	value += get_proficiency_bonus()
	value += _get_equipped_FOR_bonus()
	value += extra_fortaleza_bonus
	return value


func set_ability_level(attribute:String,ability:String,value:int=0):
	var attr = attribute.to_lower()
	var name = ability.to_lower()
	if ability_points.has(attr):
		if ability_points[attr].has(name):
			ability_points[attr][name] = value


func get_ability_mod(attribute:String,ability:String)->int:
	var attr = attribute.to_lower()
	var name = ability.to_lower()
	
	# chequeo que habilidad sea valida (este bien escrita)
	if not ability_points.has[attr]:
		return 0
	if not ability_points[attr].has[name]:
		return 0
	
	# la habilidad es valida
	var mod : int = ability_points[attr][name]
	
	# obtengo habilidades natas de clase
	var is_prof : bool = classdata.get_ability_prof(attr,name)
	
	if is_prof:
		#mod += get_proficiency_bonus()
		mod += 3
	
	mod += get_attribute_mod(attr)
	
	mod += _get_ability_bonus(attr,name)

	return mod

###############################################
# PRIVATE METHODS
###############################################

# Calculated based on inventory and/or feats
func _get_equipped_PF_bonus()->int:
	return 0
func _get_equipped_MF_bonus()->int:
	return 0
func _get_equipped_REF_bonus()->int:
	return 0
func _get_equipped_FOR_bonus()->int:
	return 0
func _get_ability_bonus(attribute:String,ability:String)->int:
	return 0
