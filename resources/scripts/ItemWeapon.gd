extends Item
class_name ItemWeapon

enum ATTACK_TYPE {
	MELEE,
	RANGED
}

var attributes : Dictionary ={
	"Fuerza":0,
	"Agilidad":1,
	"Inteligencia":2,
	"Astucia":3,
	"Carisma":4
}

export (String) var weapon_class = ""

export (ATTACK_TYPE) var attack_type = 0
export (int,5,10000) var attack_range = 5

export (Array,String) var attack_roll_attributes = []
export (String) var selected_attack_roll_attribute = 0

export (String) var damage_type = ""
export (int,2,100) var damage_dice_sides = 2
export (int,1,100) var damage_dice_quantity = 1

func add_attack_roll_attribute(attribute:String):
	if attributes.has(attribute):
		attack_roll_attributes.push_back(attribute)

func select_attack_roll_attribute(attribute:String):
	if attack_roll_attributes.has(attribute):
		selected_attack_roll_attribute = attribute

func get_attack_roll_attributes()->Array:
	return attack_roll_attributes

func get_attack()->Dictionary:
	return {
		"dice_quantity": damage_dice_quantity,
		"dice_sides": damage_dice_sides,
		"attribute_mod": selected_attack_roll_attribute,
		"weapon_class": weapon_class
	}

func set_property(name:String,value):
	match name:
		"name":
			item_name = value
			emit_changed()
			return OK
		"description":
			item_description = value
			emit_changed()
			return OK
		"class":
			weapon_class = value
			emit_changed()
			return OK
		"damage_type":
			damage_type = value
			emit_changed()
			return OK
		"attack_range":
			if value >= 5:
				attack_range = value
				emit_changed()
			else:
				attack_range = 5
				emit_changed()
			return OK
		"attack_type":
			if value == ATTACK_TYPE.MELEE or value == ATTACK_TYPE.RANGED:
				attack_type = value
				emit_changed()
			return OK
		"damage_dice_sides":
			if value >= 2 and value <=100:
				damage_dice_sides = value
				emit_changed()
			return OK
		"damage_dice_quantity":
			if value>=1:
				damage_dice_quantity = value
			else:
				damage_dice_quantity = 1
			emit_changed()
			return OK
		_:
			print("ERROR. Property ",name," does not exists.")
			return ERR_DOES_NOT_EXIST

func get_property(name:String):
	match name:
		"name":
			return item_name
		"description":
			return item_description
		"class":
			return weapon_class
		"damage_type":
			return damage_type
		"attack_range":
			return attack_range
		"attack_type":
			return attack_type
		"damage_dice_sides":
			return damage_dice_sides
		"damage_dice_quantity":
			return damage_dice_quantity
		_:
			print("ERROR. Property ",name," does not exists.")
			return ERR_DOES_NOT_EXIST
		
