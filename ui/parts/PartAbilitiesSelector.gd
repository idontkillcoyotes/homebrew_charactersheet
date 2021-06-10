extends Control

signal ability_selected(ability_name,value)

export (PackedScene) var picker_scene

onready var container = $MarginContainer/VBoxContainer/Abilities

var class_data : CharacterClassData = null

func _ready():
	self.hide()
	_populate()

func _populate():
	var abilities = GameDataManager.get_abilities()
	for ab in abilities.keys():
		var node = picker_scene.instance()
		node.set_ability_name(ab)
		node.connect("toggled",self,"_on_ability_toggled",[ab])
		container.add_child(node)

func _load_data(data:CharacterClassData):
	class_data = data
	for node in container.get_children():
		var name = node.get_ability_name()
		var prof = class_data.get_ability_prof(name)
		node.set_selected(prof)

func _on_ability_toggled(selected,ability_name):
	emit_signal("ability_selected",ability_name,selected)
	class_data.set_ability_prof(ability_name,selected)

func _clear():
	for node in container.get_children():
		node.pressed = false

func _on_ButtonDone_pressed():
	#_clear()
	self.hide()

func _on_Editor_button_abilities_pressed(class_data):
	_load_data(class_data)
	self.show()
