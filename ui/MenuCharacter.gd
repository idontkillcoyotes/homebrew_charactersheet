extends MenuButton

const OPTIONS = {
	0:"Nuevo Personaje",
	1:"Cargar Personaje",
	2:"Guardar Personaje"
}


var popup: PopupMenu



func _ready():
	popup = get_popup()
	popup.connect("index_pressed",self,"_on_index_pressed")
	_populate()

func _populate():
	for k in OPTIONS.keys():
		if OPTIONS[k]!="separator":
			popup.add_item(OPTIONS[k],k)
		else:
			popup.add_separator("",k)

func _new_character():
	CharacterDataManager.new_character("oliver.tres")

func _load_character():
	CharacterDataManager.load_character("oliver.tres")

func _save_character():
	CharacterDataManager.save_character()

func _on_index_pressed(index):
	match OPTIONS[index]:
		"Nuevo Personaje":
			_new_character()
		"Cargar Personaje":
			_load_character()
		"Guardar Personaje":
			_save_character()
	
