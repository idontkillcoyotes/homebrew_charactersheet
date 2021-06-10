extends Resource
class_name CharacterData

# Personal data
export var character_name : String = ""
export var character_age : int = 0
export (Resource) var classdata
export var character_exp : int = 0
export var character_level : int = 0

# HP
export var current_hp : int = 0
export var max_hp : int = 0

# Attributes scores
export var attributes: Dictionary = {
	"fuerza":0,
	"agilidad":0,
	"inteligencia":0,
	"astucia":0,
	"carisma":0
}

# Base number for all classes
export var base_reflexes : int = 8
export var base_fortaleza : int = 8

# Extra permanent bonuses
export var extra_physical_resistance : int = 0
export var extra_magical_resistance : int = 0
export var extra_reflexes_bonus : int = 0
export var extra_fortaleza_bonus : int = 0

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

# Inventory
export var inventory : Array = []

###################################################
# PUBLIC METHODS
###################################################

func add_item(item:Item):
	inventory.push_back(item)

func set_attribute(attribute:String,value:int):
	var name = attribute.to_lower()
	if value>=0 and attributes.has(name):
		attributes[name] = value

func get_attribute(attribute:String)->int:
	var name = attribute.to_lower()
	if attributes.has(name):
		return attributes[name]
	else:
		return -1

func set_ability_level(attribute:String,ability:String,value:int=0):
	var attr = attribute.to_lower()
	var name = ability.to_lower()
	if ability_points.has(attr):
		if ability_points[attr].has(name):
			ability_points[attr][name] = value

func get_property(name:String):
	name = name.to_lower()
	match name:
		"name":
			return character_name
		"age":
			return character_age
		"level":
			return character_level
		"exp":
			return character_exp
		"class":
			return classdata
		"current_hp":
			return current_hp
		"max_hp":
			return max_hp
		"proficiency":
			return _get_proficiency_bonus()
		"physical_resistance":
			return _get_physical_resistance()
		"magical_resistance":
			return _get_magical_resistance()
		"reflexes":
			return _get_reflexes()
		"fortaleza":
			return _get_fortaleza()
		_:
			return null

func set_property(name:String,value):
	name = name.to_lower()
	match name:
		"name":
			character_name = value
			return OK
		"age":
			character_age = value
			return OK
		"level":
			character_level = value
			return OK
		"exp":
			character_exp = value
			return OK
		"class":
			classdata = value
			return OK
		"current_hp":
			current_hp = value
			return OK
		"max_hp":
			max_hp = value
			return OK
		_:
			return ERR_DOES_NOT_EXIST

###############################################
# PRIVATE METHODS
###############################################

func _get_attribute_mod(attribute:String)->int:
	var name = attribute.to_lower()
	if attributes.has(name):
		return int((attributes[name]-10)/2)
	else:
		return 0

func _get_proficiency_bonus():
	if character_level <= 4:
		return classdata.base_bonus_proficiency
	else:
		var extra = int((character_level-2)/3)
		return (classdata.base_bonus_proficiency + extra)

func _get_physical_resistance()->int:
	var value = classdata.base_physical_resistance
	value += _get_equipped_PF_bonus()
	value += _get_attribute_mod("agilidad")
	value += extra_physical_resistance
	return value

func _get_magical_resistance()->int:
	var value = classdata.base_magical_resistance
	value += _get_equipped_MF_bonus()
	value += extra_magical_resistance
	return value

func _get_reflexes()->int:
	var value = base_reflexes
	value += _get_attribute_mod("agilidad")
	value += _get_proficiency_bonus()
	value += _get_equipped_REF_bonus()
	value += extra_reflexes_bonus
	return value

func _get_fortaleza()->int:
	var value = base_fortaleza
	value += _get_attribute_mod("fuerza")
	value += _get_proficiency_bonus()
	value += _get_equipped_FOR_bonus()
	value += extra_fortaleza_bonus
	return value

func _get_ability_mod(attribute:String,ability:String)->int:
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
		mod += 3
	
	mod += _get_attribute_mod(attr)
	mod += _get_ability_bonus(attr,name)

	return mod

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
