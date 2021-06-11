extends PanelContainer

signal button_classes_pressed
signal button_items_pressed


func _on_ButtonExit_pressed():
	CharacterDataManager.save_character()
	get_tree().quit()

func _on_ButtonClasses_pressed():
	emit_signal("button_classes_pressed")

func _on_ButtonItems_pressed():
	emit_signal("button_items_pressed")
