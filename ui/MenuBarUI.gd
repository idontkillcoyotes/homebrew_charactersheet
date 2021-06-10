extends PanelContainer

signal button_classes_pressed
signal button_exit_pressed

func _on_MenuClasses_pressed():
	emit_signal("button_classes_pressed")

func _on_ButtonExit_pressed():
	emit_signal("button_exit_pressed")
