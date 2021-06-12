extends ItemList

signal selected_item(index)
signal selected_nothing

var selected_item_index : int = -1

func reload():
	_populate()

func _ready():
	_populate()

func _populate():
	selected_item_index = 0
	self.clear()
	CharacterDataManager.update_characters()
	var items = CharacterDataManager.get_characters()
	
	if items.size()>0:
		var i : int = 0
		var noname_count : int = 0
		for item in items:
			var data : CharacterData = item["data"]
			var name : String = data.character_name
			if name == "":
				name = "personaje sin nombre"
				if noname_count >= 1:
					name +=" ("+str(noname_count)+")"
				noname_count += 1
			add_item(name)
			var meta : Dictionary = {
				"id":i
			}
			set_item_metadata(i,meta)
			i+=1
	self.sort_items_by_text()


func get_selected_item()->int:
	return selected_item_index

func _on_ItemsList_item_selected(index):
	var id : int = get_item_metadata(index)["id"]
	selected_item_index = id
	emit_signal("selected_item",selected_item_index)

func _on_ItemsList_nothing_selected():
	selected_item_index = -1
	emit_signal("selected_nothing")

func _on_ItemsList_item_activated(index):
	var id : int = get_item_metadata(index)["id"]
	selected_item_index = id
	emit_signal("selected_item",selected_item_index)
