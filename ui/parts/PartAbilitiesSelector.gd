extends Control

export (PackedScene) var picker_scene

onready var container = $PanelContainer/MarginContainer/Abilities

var list : Array = []

func _ready():
	_populate()

func _populate():
	var abilities = GameDataManager.get_abilities()
	for ab in abilities.keys():
		var node = picker_scene.instance()
		node.set_ability_name(ab)
		list.push_back(node)
		container.add_child(node)
	
	
