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
	"Agarrar persona":{
		"level":0,
		"extra":0
	},
	"Analizar muestra":{
		"level":0,
		"extra":0
	},
	"Atletismo":{
		"level":0,
		"extra":0
	},
	"Averiguar intenciones":{
		"level":0,
		"extra":0
	},
	"Destruir":{
		"level":0,
		"extra":0
	},
	"Disfrazarse":{
		"level":0,
		"extra":0
	},
	"Historia":{
		"level":0,
		"extra":0
	},
	"Interpretacion":{
		"level":0,
		"extra":0
	},
	"Investigacion":{
		"level":0,
		"extra":0
	},
	"Intimidar":{
		"level":0,
		"extra":0
	},
	"Juego de manos":{
		"level":0,
		"extra":0
	},
	"Linguistica":{
		"level":0,
		"extra":0
	},
	"Manualidades":{
		"level":0,
		"extra":0
	},
	"Medicina":{
		"level":0,
		"extra":0
	},
	"Mover grandes objetos":{
		"level":0,
		"extra":0
	},
	"Naturaleza":{
		"level":0,
		"extra":0
	},
	"Ocultarse":{
		"level":0,
		"extra":0
	},
	"Ocultismo":{
		"level":0,
		"extra":0
	},
	"Percepcion":{
		"level":0,
		"extra":0
	},
	"Persuasion":{
		"level":0,
		"extra":0
	},
	"Sigilo":{
		"level":0,
		"extra":0
	},
	"Trepar":{
		"level":0,
		"extra":0
	},
	"Tumbar":{
		"level":0,
		"extra":0
	}
}

# Inventory
export var inventory : Array = []

###################################################
# PUBLIC METHODS
###################################################

func add_inventory_item(item:Item):
	var entry : Dictionary = {
		"data": item,
		"equiped" : false
	}
	inventory.push_back(entry)
	emit_changed()

func set_item_equiped(index:int,value:bool):
	var item : Dictionary = inventory[index]
	item["equiped"] = value
	emit_changed()

func get_inventory()->Array:
	return inventory

func set_class_data(data:CharacterClassData):
	classdata = data
	classdata.connect("changed",self,"_on_class_changed")
	emit_changed()

func set_attribute(attribute:String,value:int):
	var name = attribute.to_lower()
	if value>=0 and attributes.has(name):
		attributes[name] = value
		emit_changed()

func get_attribute(attribute:String)->int:
	var name = attribute.to_lower()
	if attributes.has(name):
		return attributes[name]
	else:
		return 0

func get_attribute_mod(attribute:String)->int:
	var name = attribute.to_lower()
	if attributes.has(name):
		return int((attributes[name]-10)/2)
	else:
		return 0

func set_ability_level(ability:String,value:int=0):
	if ability_points.has(ability):
		ability_points[ability]["level"] = value
		emit_changed()
func set_ability_extra(ability:String,value:int=0):
	if ability_points.has(ability):
		ability_points[ability]["extra"] = value
		emit_changed()

func get_ability_level(ability:String)->int:
	if ability_points.has(ability):
		return ability_points[ability]["level"]
	else:
		return 0

func get_ability_extra(ability:String)->int:
	if ability_points.has(ability):
		return ability_points[ability]["extra"]
	else:
		return 0

func is_proficient(ability_name:String)->bool:
	if classdata:
		return classdata.get_ability_prof(ability_name)
	else:
		return false

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
		"extra_physical_resistance":
			return extra_physical_resistance
		"extra_magical_resistance":
			return extra_magical_resistance
		"extra_reflexes":
			return extra_reflexes_bonus
		"extra_fortaleza":
			return extra_fortaleza_bonus
		_:
			return null

func set_property(name:String,value):
	name = name.to_lower()
	match name:
		"name":
			character_name = value
			emit_changed()
			return OK
		"age":
			character_age = value
			emit_changed()
			return OK
		"level":
			character_level = value
			emit_changed()
			return OK
		"exp":
			character_exp = value
			emit_changed()
			return OK
		"class":
			classdata = value
			emit_changed()
			return OK
		"current_hp":
			current_hp = value
			emit_changed()
			return OK
		"max_hp":
			max_hp = value
			emit_changed()
			return OK
		"extra_physical_resistance":
			extra_physical_resistance = value
			emit_changed()
			return OK
		"extra_magical_resistance":
			extra_magical_resistance = value
			emit_changed()
			return OK
		"extra_reflexes":
			extra_reflexes_bonus = value
			emit_changed()
			return OK
		"extra_fortaleza":
			extra_fortaleza_bonus = value
			emit_changed()
			return OK
		_:
			return ERR_DOES_NOT_EXIST



###############################################
# PRIVATE METHODS
###############################################

func _get_proficiency_bonus():
	if classdata != null:
		if character_level <= 4:
			return classdata.base_bonus_proficiency
		else:
			var extra = int((character_level-2)/3)
			return (classdata.base_bonus_proficiency + extra)
	else:
		return 0

func _get_physical_resistance()->int:
	var value : int = 0
	if classdata != null:
		value += classdata.base_physical_resistance
	value += get_attribute_mod("agilidad")
	value += _get_equipped_PR_bonus()
	value += _get_proficiency_bonus()
	value += extra_physical_resistance
	return value

func _get_magical_resistance()->int:
	var value : int = 0
	if classdata != null:
		value = classdata.base_magical_resistance
	value += _get_equipped_MR_bonus()
	value += _get_proficiency_bonus()
	value += extra_magical_resistance
	return value

func _get_reflexes()->int:
	var value : int = 0
	if classdata != null:
		value = base_reflexes
	value += get_attribute_mod("agilidad")
	value += _get_proficiency_bonus()
	value += _get_equipped_REF_bonus()
	value += extra_reflexes_bonus
	return value

func _get_fortaleza()->int:
	var value : int = 0
	if classdata != null:
		value = base_fortaleza
	value += get_attribute_mod("fuerza")
	value += _get_proficiency_bonus()
	value += _get_equipped_FOR_bonus()
	value += extra_fortaleza_bonus
	return value

func _on_class_changed():
	emit_changed()

# Calculated based on inventory and/or feats
func _get_equipped_PR_bonus()->int:
	var sum : int = 0
	if inventory.size()>0:
		for item in inventory:
			var data = item["data"]
			var equiped = item["equiped"]
			if equiped:
				sum += data.get_bonus_PR()
	return sum

func _get_equipped_MR_bonus()->int:
	var sum : int = 0
	if inventory.size()>0:
		for item in inventory:
			var data = item["data"]
			var equiped = item["equiped"]
			if equiped:
				sum += data.get_bonus_MR()
	return sum
func _get_equipped_REF_bonus()->int:
	var sum : int = 0
	if inventory.size()>0:
		for item in inventory:
			var data = item["data"]
			var equiped = item["equiped"]
			if equiped:
				sum += data.get_bonus_reflexes()
	return sum
func _get_equipped_FOR_bonus()->int:
	var sum : int = 0
	if inventory.size()>0:
		for item in inventory:
			var data = item["data"]
			var equiped = item["equiped"]
			if equiped:
				sum += data.get_bonus_fortaleza()
	return sum

