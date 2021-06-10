extends ItemList

signal class_deselected
signal class_selected(class_data)

var selected_class : CharacterClassData = null

func _ready():
	_populate()

func reload():
	_populate()

func _populate():
	selected_class = null
	clear()
	
	GameDataManager.update_classes()
	var classes = GameDataManager.get_classes()
	
	if classes.size()>0:
		for c in classes:
			self.add_item(c.name)


func get_selected_class()->CharacterClassData:
	return selected_class

func _on_ClassesList_item_selected(_index):
	var id = get_selected_items()[0]
	selected_class = GameDataManager.get_classes()[id]
	emit_signal("class_selected",selected_class)

func _on_ClassesList_nothing_selected():
	selected_class = null
	emit_signal("class_deselected")
