extends Control

onready var explorer = $Explorer

func _on_MenuBar_button_items_pressed():
	explorer.open()
