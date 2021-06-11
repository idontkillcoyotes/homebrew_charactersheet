extends ItemList

func get_selected_attributes()->Array:
	if is_anything_selected():
		var ids : Array = get_selected_items()
		var selected : Array = []
		for index in ids:
			selected.push_back(GameDataManager.get_attribute_by_id(index))
		
		return selected
	else:
		return ["Fuerza"]
	

func set_selected_attributes(list:Array):
	if list.size()>0:
		var attr = GameDataManager.get_attributes()
		for item in list:
			if attr.has(item):
				self.select(attr[item],false)
	else:
		self.select(0,true)
