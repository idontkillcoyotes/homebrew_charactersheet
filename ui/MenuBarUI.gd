extends PanelContainer

signal button_classes_pressed

func _on_MenuClasses_pressed():
	emit_signal("button_classes_pressed")
