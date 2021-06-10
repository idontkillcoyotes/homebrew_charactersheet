extends VBoxContainer

onready var atr1 = $Attribute1
onready var atr2 = $Attribute2
onready var atr3 = $Attribute3
onready var atr4 = $Attribute4
onready var atr5 = $Attribute5

func _ready():
	_load_data()
	
func _load_data():
	var chardata = CharacterDataManager.get_current_character()
	var char_attr = chardata.attributes
	print(char_attr)
	atr1.set_display_name("Fuerza")
	atr1.set_character_stat_name("fuerza")
	atr1.load_data()
	
	atr2.set_display_name("Agilidad")
	atr2.set_character_stat_name("agilidad")
	atr2.load_data()
	
	atr3.set_display_name("Inteligencia")
	atr3.set_character_stat_name("inteligencia")
	atr3.load_data()
	
	atr4.set_display_name("Astucia")
	atr4.set_character_stat_name("astucia")
	atr4.load_data()
	
	atr5.set_display_name("Carisma")
	atr5.set_character_stat_name("carisma")
	atr5.load_data()
