extends Control

onready var atr1 = $PanelContainer/VBoxContainer/Attribute1
onready var atr2 = $PanelContainer/VBoxContainer/Attribute2
onready var atr3 = $PanelContainer/VBoxContainer/Attribute3
onready var atr4 = $PanelContainer/VBoxContainer/Attribute4
onready var atr5 = $PanelContainer/VBoxContainer/Attribute5

func _ready():
	CharacterDataManager.connect("data_loaded",self,"_on_character_data_loaded")
	
func _on_character_data_loaded():
	_load_data()

func _load_data():
	var chardata = CharacterDataManager.get_current_character()
	var char_attr = chardata.attributes
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
