extends Item
class_name ItemEquipable

enum SLOT_TYPE {
	TORSO,
	HEAD,
	HANDS,
	FEET,
	NECK,
	RING,
	OTHER
}

export (String) var item_class = ""
export (SLOT_TYPE) var slot = 0
export (int,0,50) var physical_resistance = 0
export (int,0,50) var magical_resistance = 0
export (int) var mod_reflexes = 0
export (int) var mod_fortaleza = 0
export (int,0,10) var sockets_total = 0 

export (Array,Resource) var socketed_items : Array = [] 

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
			item_class = value
			emit_changed()
			return OK
		"slot_type":
			if value >=0 and value <=5:
				slot = value
				emit_changed()
			return OK
		"sockets":
			value = int(value)
			if value>=0:
				sockets_total = value
				emit_changed()
			return value
		"physical_resistance":
			value = int(value)
			if value >=0:
				physical_resistance = value
				emit_changed()
			return value
		"magical_resistance":
			value = int(value)
			if value >=0:
				magical_resistance = value
				emit_changed()
			return value
		"mod_reflexes":
			value = int(value)
			mod_reflexes = value
			emit_changed()
			return value
		"mod_fortaleza":
			value = int(value)
			mod_fortaleza = value
			emit_changed()
			return value
		_:
			print("ERROR. Property ",name," does not exists")
			return ERR_DOES_NOT_EXIST


func get_property(name:String):
	match name:
		"name":
			return item_name
		"description":
			return item_description
		"class":
			return item_class
		"slot_type":
			return slot
		"sockets":
			return sockets_total
		"physical_resistance":
			return physical_resistance
		"magical_resistance":
			return magical_resistance
		"mod_reflexes":
			return mod_reflexes
		"mod_fortaleza":
			return mod_fortaleza
		_:
			print("ERROR. Property ",name," does not exists")
			return ERR_DOES_NOT_EXIST

func add_socketed_item(item:Item):
	if sockets_total>0:
		if socketed_items.size()<sockets_total:
			socketed_items.push_back(item)
			emit_changed()

func get_socketed_items()->Array:
	return socketed_items

func get_bonus_PR()->int:
	var value : int = 0
	if socketed_items.size()>0:
		for item in socketed_items:
			value += item.get_bonus_PR()
	value += physical_resistance
	return value

func get_bonus_MR()->int:
	var value : int = 0
	if socketed_items.size()>0:
		for item in socketed_items:
			value += item.get_bonus_MR()
	value += magical_resistance
	return value

func get_bonus_reflexes()->int:
	var value : int = 0
	if socketed_items.size()>0:
		for item in socketed_items:
			value += item.get_mod_reflexes()
	value += mod_reflexes
	return value

func get_bonus_fortaleza()->int:
	var value : int = 0
	if socketed_items.size()>0:
		for item in socketed_items:
			value += item.get_mod_fortaleza()
	value += mod_fortaleza
	return value


