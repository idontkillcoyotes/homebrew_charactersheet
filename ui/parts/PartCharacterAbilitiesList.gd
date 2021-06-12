extends Control

export (PackedScene) var ability_scene

onready var container = $PanelContainer/GridContainer/PanelContainer/List

func _ready():
	_populate()

func _populate():
	for key in GameDataManager.get_abilities().keys():
		var node = ability_scene.instance()
		node.set_ability_name(key)
		container.add_child(node)
