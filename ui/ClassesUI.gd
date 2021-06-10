extends Control

onready var explorer = $Explorer
onready var editor = $Editor
onready var selector = $AbilitiesSelector

func show_class_explorer():
	explorer.open()

func _on_MenuBar_button_classes_pressed():
	show_class_explorer()
