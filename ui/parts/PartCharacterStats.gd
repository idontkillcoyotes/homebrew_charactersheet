extends HBoxContainer

export (PackedScene) var stat_scene


func _ready():
	_populate()

func _populate():
	var stats = GameDataManager.get_stats()
	for key in stats.keys():
		var node = stat_scene.instance()
		node.set_display_name(stats[key])
		node.set_stat_name(key)
		add_child(node)
	
