extends OptionButton

var selected_class_name : String = ""

func _ready():
	_populate_options()
	_load_data()

func _load_data():
	var chardata = CharacterDataManager.get_current_character()
	
	selected_class_name = chardata.classdata.name
	
	var id = 0
	for i in get_item_count():
		if get_item_text(i) == selected_class_name:
			id = i
	
	select(id)

func _populate_options():
	var classes = GameDataManager.get_classes()
	
	if classes.size()>0:
		for c in classes:
			self.add_item(c.name)

func _update_data():
	var selected_class = GameDataManager.get_class_by_name(selected_class_name)
	var chardata = CharacterDataManager.get_current_character()
	
	chardata.classdata = selected_class
	
	CharacterDataManager.save_character()

func _on_ClassSelector_item_selected(_index):
	selected_class_name = get_item_text(get_selected_id())
	_update_data()
