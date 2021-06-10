extends CheckBox

export (String) var ability_name = "Ability" setget set_ability_name,get_ability_name

func _ready():
	self.text = _get_ability_text()

func set_ability_name(name:String):
	ability_name = name
	self.text = _get_ability_text()

func get_ability_name()->String:
	return ability_name

func _get_ability_text()->String:
	var text = ability_name
	var abilities = GameDataManager.get_abilities()
	var atr = GameDataManager.get_attribute_by_id(abilities[ability_name])
	text += " ("+atr+")"
	return text

func is_selected()->bool:
	return self.pressed
func set_selected(value:bool):
	set_pressed(value)
