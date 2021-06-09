extends Item
class_name ItemEquipable

enum SLOT_TYPE {
	TORSO,
	HEAD,
	HANDS,
	FEET,
	NECK,
	RING
}

export (bool) var equipped = false
export (SLOT_TYPE) var slot = 0

export (int,0,50) var physical_resistance = 0
export (int,0,50) var magical_resistance = 0
export (int) var mod_reflexes = 0
export (int) var mod_fortaleza = 0

export (int,0,10) var sockets_total = 0 setget _set_sockets_total

var socketed_items : Array = [] 

func _set_sockets_total(value:int):
	if value>=0:
		sockets_total = value
		socketed_items.resize(value)

func get_slot_type()->int:
	return slot

func add_socketed_item(item:Item):
	if sockets_total>0:
		if socketed_items.size()<sockets_total:
			socketed_items.push_back(item)

func get_bonus_PR()->int:
	var value : int = 0
	if equipped:
		if socketed_items.size()>0:
			for item in socketed_items.size():
				value += item.get_bonus_PR()
		value += physical_resistance
	
	return value

func get_mod_reflexes()->int:
	var value : int = 0
	if equipped:
		if socketed_items.size()>0:
			for item in socketed_items.size():
				value += item.get_mod_reflexes()
		value += mod_reflexes
	
	return value

func get_mod_fortaleza()->int:
	var value : int = 0
	if equipped:
		if socketed_items.size()>0:
			for item in socketed_items.size():
				value += item.get_mod_fortaleza()
		value += mod_fortaleza
	
	return value

func get_bonus_MR()->int:
	var value : int = 0
	if equipped:
		if socketed_items.size()>0:
			for item in socketed_items.size():
				value += item.get_bonus_MR()
		value += magical_resistance
	
	return value
