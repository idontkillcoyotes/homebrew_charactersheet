extends Control

signal button_classes_pressed
signal button_items_pressed
signal button_close_sheet_pressed

func _on_ButtonExit_pressed():
	CharacterDataManager.save_character()
	get_tree().quit()

func _on_ButtonClasses_pressed():
	emit_signal("button_classes_pressed")

func _on_ButtonItems_pressed():
	emit_signal("button_items_pressed")

func _on_MenuCharacter_close_character():
	emit_signal("button_close_sheet_pressed")

func _on_ButtonFolder_pressed():
	OS.shell_open(ProjectSettings.globalize_path("user://gamedata"))
