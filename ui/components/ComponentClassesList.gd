extends ItemList

signal selected_item(index)
signal selected_nothing

var selected_item_index : int = -1

func _ready():
	_populate()

func reload():
	_populate()

func _populate():
	selected_item_index = -1
	clear()
	
	GameDataManager.update_classes()
	var list = GameDataManager.get_classes()
	
	if list.size()>0:
		var i : int = 0
		for item in list:
			var data = item["data"]
			var name : String = data.name
			add_item(name)
			var meta : Dictionary = {
				"id":i
			}
			set_item_metadata(i,meta)
			i+=1
	
	self.sort_items_by_text()

func get_selected_item()->int:
	return selected_item_index

func _on_item_selected(index):
	var id : int = get_item_metadata(index)["id"]
	selected_item_index = id
	emit_signal("selected_item",selected_item_index)

func _on_nothing_selected():
	selected_item_index = -1
	emit_signal("selected_nothing")
