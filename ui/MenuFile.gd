extends MenuButton

var popup: PopupMenu

func _ready():
	popup = get_popup()
	popup.connect("index_pressed",self,"_on_index_pressed")

func _on_index_pressed(index):
	pass
