extends OptionButton

var selected_id : int = -1 setget set_selected_attribute,get_selected_attribute

func _ready():
	_populate()
	set_selected_attribute(0)

func _populate():
	var dict : Dictionary = GameDataManager.get_attributes()
	for atr in dict.keys():
		self.add_item(atr,dict[atr])

func get_selected_attribute()->int:
	return selected_id
func set_selected_attribute(value:int):
	selected_id = value
	self.text = GameDataManager.get_attribute_name(selected_id)

func _on_AttributePicker_item_selected(index):
	self.text = get_item_text(index)
	selected_id = get_item_id(index)
