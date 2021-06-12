extends PanelContainer

signal button_add_pressed

export (PackedScene) var item_scene

onready var container = $GridContainer/Inventory

func add_new_item(data:Item):
	var chardata = CharacterDataManager.get_current_character()
	chardata.add_inventory_item(data)

func _ready():
	CharacterDataManager.connect("data_updated",self,"_on_data_updated")
	CharacterDataManager.connect("data_loaded",self,"_on_character_data_loaded")
	
func _on_character_data_loaded():
	_populate()

func _on_data_updated():
	_populate()

func _populate():
	var chardata = CharacterDataManager.get_current_character()
	
	for c in container.get_children():
		c.queue_free()
	
	var list = chardata.get_inventory()
	
	#print("InvPanel. Populate. inventory_list=",list)
	if list.size()>0:
		for i in list.size():
			var node = item_scene.instance()
			container.add_child(node)
			#print("list[i]=",list[i])
			var data = list[i]
			node.load_data(data,i)


func _on_ButtonAdd_pressed():
	emit_signal("button_add_pressed")

func _on_ItemSelector_item_selected(entry):
	add_new_item(entry["data"])
