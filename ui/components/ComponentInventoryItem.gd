extends HBoxContainer

signal item_equiped(value)

var itemdata = null
var equiped : bool = false
var index : int = -1
var is_weapon : bool = false

onready var in_name = $InputName
onready var in_PR = $InputPR
onready var in_MR = $InputMR
onready var in_ref = $InputRef
onready var in_fort = $InputFort
onready var in_equip = $InputEquiped

onready var inputs : Array = [in_name,in_PR,in_MR,in_ref,in_fort]

export (bool) var editable = false setget set_editable

func _ready():
	_update_editables()

func set_editable(value:bool):
	editable = value
	_update_editables()

func _update_editables():
	if inputs != null:
		for input in inputs:
			if input != null:
				input.set_editable(editable)

func load_data(entry:Dictionary,idx:int):
	#print("CompInvItem: entry=",entry," index=",idx)
	itemdata = entry["data"]
	equiped = entry["equiped"]
	index = idx

	if itemdata is ItemWeapon:
		is_weapon = true
	
	_load()

func _load():
	if not is_weapon:
		in_name.set_text(itemdata.get_property("name"))
		in_PR.set_value(itemdata.get_property("physical_resistance"))
		in_MR.set_value(itemdata.get_property("magical_resistance"))
		in_ref.set_value(itemdata.get_property("mod_reflexes"))
		in_fort.set_value(itemdata.get_property("mod_fortaleza"))
		in_equip.pressed = equiped
	else:
		var text = _generate_weapon_text()
		in_name.set_text(text)
		_show_weapon_ui(true)

func _generate_weapon_text()->String:
	var data : Dictionary = itemdata.get_attack_data()
	var text : String = data["name"]+" | Ataque: 1d20+"
	text+=data["attribute_mod"]
	text+=" | Daño: "+data["dice_quantity"]+"d"+data["damage_dice"]
	text+=". "+data["damage_type"]
	text+=" | Rango: "+data["range"]+" pies."
	return text

func _show_weapon_ui(show:bool):
	$Separator1.visible = not show
	$Separator2.visible = not show
	$Separator3.visible = not show
	$Separator4.visible = not show
	$Separator5.visible = not show
	in_equip.visible = not show
	in_PR.visible = not show
	in_MR.visible = not show
	in_ref.visible = not show
	in_fort.visible = not show

func _equip(value:bool):
	equiped = value
	if not is_weapon:
		var chardata = CharacterDataManager.get_current_character()
		chardata.set_item_equiped(index,equiped)
	emit_signal("item_equiped",index)

func _on_InputEquiped_pressed():
	_equip(in_equip.get_toggled())
