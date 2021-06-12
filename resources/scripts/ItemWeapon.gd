extends Item
class_name ItemWeapon

enum ATTACK_TYPE {
	MELEE,
	RANGED
}

export (String) var weapon_class = ""

export (ATTACK_TYPE) var attack_type = 0
export (int,5,10000) var attack_range = 5

export (Array,String) var attack_roll_attributes = []

export (String) var damage_type = ""
export (int,2,100) var damage_dice_sides = 2
export (int,1,100) var damage_dice_quantity = 1

func set_attack_roll_attribute(list:Array):
	attack_roll_attributes = []
	for item in list:
		attack_roll_attributes.push_back(item)

func get_attack_roll_attributes()->Array:
	return attack_roll_attributes

func get_attack_data()->Dictionary:
	return {
		"name": str(item_name),
		"dice_quantity": str(damage_dice_quantity),
		"damage_dice": str(damage_dice_sides),
		"damage_type": str(damage_type),
		"attribute_mod": str(attack_roll_attributes),
		"class": str(weapon_class),
		"attack_type":attack_type,
		"range": str(attack_range)
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
			value = int(value)
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
			value = int(value)
			if value >= 2 and value <=100:
				damage_dice_sides = value
				emit_changed()
			return OK
		"damage_dice_quantity":
			value = int(value)
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
		
