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
	atr1.set_attrname("Fuerza")
	atr1.set_value(char_attr["Fuerza"])	
	atr2.set_attrname("Agilidad")
	atr2.set_value(char_attr["Agilidad"])	
	atr3.set_attrname("Inteligencia")
	atr3.set_value(char_attr["Inteligencia"])	
	atr4.set_attrname("Astucia")
	atr4.set_value(char_attr["Astucia"])	
	atr5.set_attrname("Carisma")
	atr5.set_value(char_attr["Carisma"])
