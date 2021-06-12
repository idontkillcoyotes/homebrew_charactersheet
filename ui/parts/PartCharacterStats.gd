extends Control

export (PackedScene) var stat_scene

onready var container = $PanelContainer/MarginContainer/Container

func _ready():
	_populate()

func _populate():
	var stats = GameDataManager.get_stats()
	for key in stats.keys():
		var node = stat_scene.instance()
		node.set_display_name(stats[key])
		node.set_stat_name(key)
		container.add_child(node)
