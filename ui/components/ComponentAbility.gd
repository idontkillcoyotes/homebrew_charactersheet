extends HBoxContainer

export (String) var ability_name = "ability" setget set_ability_name

onready var in_level = $InputLevels
onready var in_extra = $InputExtra
onready var in_prof = $CheckProf

onready var label_mod = $LabelMod
onready var label_name = $LabelName

var mod : int = 0
var attribute : String = ""

func _ready():
	CharacterDataManager.connect("data_updated",self,"_on_data_updated")
	
	label_name.text = _get_ability_text()
	_load_data()

func _load_data():
	var chardata = CharacterDataManager.get_current_character()
	in_level.set_value(chardata.get_ability_level(ability_name))
	in_extra.set_value(chardata.get_ability_extra(ability_name))
	in_prof.set_pressed(chardata.is_proficient(ability_name))
	
	_calculate()

func set_ability_name(name:String):
	ability_name = name

func _on_data_updated():
	_load_data()

func _calculate():
	var level : int = in_level.get_value()
	var extra : int = in_extra.get_value()
	var prof : bool = in_prof.is_pressed()	
	var attr_mod : int = CharacterDataManager.get_current_character().get_attribute_mod(attribute)
	
	mod = level + extra + attr_mod
	if prof:
		mod +=3
	
	label_mod.text = "Total: +"+str(mod)

func _get_ability_text()->String:
	var text = ability_name
	attribute = GameDataManager.get_ability_attribute(ability_name)
	text += " ("+attribute+")"
	return text


func _on_InputLevels_value_changed(_value):
	var val : int = int(_value)
	CharacterDataManager.get_current_character().set_ability_level(ability_name,val)
	CharacterDataManager.save_character()

func _on_InputExtra_value_changed(_value):
	var val : int = int(_value)
	CharacterDataManager.get_current_character().set_ability_extra(ability_name,val)
	CharacterDataManager.save_character()

func _on_CheckProf_toggled(_pressed):
	pass
