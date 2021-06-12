extends MenuButton

signal button_load_pressed
signal close_character

const OPTIONS = {
	0:"Nuevo Personaje",
	1:"Cargar Personaje",
	2:"Guardar Personaje",
	3:"Cerrar"
}
var popup: PopupMenu

func _ready():
	CharacterDataManager.connect("data_loaded",self,"_on_character_data_loaded")
	popup = get_popup()
	popup.connect("index_pressed",self,"_on_index_pressed")
	_populate()

func _on_character_data_loaded():
	popup.set_item_disabled(2,false)
	popup.set_item_disabled(3,false)

func _populate():
	for k in OPTIONS.keys():
		if OPTIONS[k]!="separator":
			popup.add_item(OPTIONS[k],k)
		else:
			popup.add_separator("",k)
	
	popup.set_item_disabled(2,true)
	popup.set_item_disabled(3,true)

func _new_character():
	CharacterDataManager.new_character()

func _load_character():
	emit_signal("button_load_pressed")

func _save_character():
	CharacterDataManager.save_character()

func _close_character():
	popup.set_item_disabled(2,true)
	popup.set_item_disabled(3,true)
	emit_signal("close_character")

func _on_index_pressed(index):
	match OPTIONS[index]:
		"Nuevo Personaje":
			_new_character()
		"Cargar Personaje":
			_load_character()
		"Guardar Personaje":
			_save_character()
		"Cerrar":
			_close_character()

	
