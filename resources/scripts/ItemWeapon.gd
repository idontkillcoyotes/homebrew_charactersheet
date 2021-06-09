extends Item
class_name ItemWeapon

enum ATTACK_TYPE {
	MELEE,
	RANGED
}
enum ATTRIBUTES {
	FUERZA,
	AGILIDAD,
	INTELIGENCIA,
	ASTUCIA,
	CARISMA
}
export (String) var weapon_class = ""
export (String) var damage_type = ""

export (ATTACK_TYPE) var attack_type = 0
export (Array,ATTRIBUTES) var attack_roll_attribute = []

export (Resource) var damage_dice_type
export (int) var damage_dice_quantity = 1

export (int) var attack_range = 5
