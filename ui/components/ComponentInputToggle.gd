extends CheckBox
tool

export var toggled : bool = false setget set_toggled,get_toggled

func _ready():
	pressed = toggled
	_update_text()

func get_toggled()->bool:
	return toggled

func set_toggled(value:bool):
	toggled = value
	pressed = toggled
	_update_text()

func _update_text():
	if toggled:
		self.text = "SI"
	else:
		self.text = "NO"

func _on_InputToggle_toggled(pressed):
	set_toggled(pressed)
