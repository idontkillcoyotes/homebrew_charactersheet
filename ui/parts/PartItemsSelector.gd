extends PanelContainer

signal closed
signal item_selected(data)

onready var item_list = $VBoxContainer/Contents/ItemsList

var selected : Dictionary

func open():
	self.show()
	item_list.reload()

func close():
	self.hide()
	emit_signal("closed")

func _ready():
	self.hide()

func _on_ButtonClose_pressed():
	close()

func _on_ItemsList_selected_item(index):
	var itemdata = GameDataManager.get_item_at(index)
	self.close()
	emit_signal("item_selected",itemdata)

func _on_InventoryList_button_add_pressed():
	self.open()
