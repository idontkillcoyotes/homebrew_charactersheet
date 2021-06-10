extends PanelContainer

signal button_classes_pressed

func _exit():
	CharacterDataManager.save_character()
	get_tree().quit()

func _on_MenuClasses_pressed():
	emit_signal("button_classes_pressed")

func _on_ButtonExit_pressed():
	_exit()
