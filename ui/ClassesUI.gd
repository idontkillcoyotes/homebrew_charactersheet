extends Control

onready var explorer = $Explorer

func _on_MenuBar_button_classes_pressed():
	explorer.open()
