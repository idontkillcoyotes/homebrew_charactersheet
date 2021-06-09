extends LineEdit
class_name NumberInput

signal value_changed(value)
signal editing_stopped

export (int,0,1000000) var value = 0 setget set_value,get_value
export (int,0,1000000) var min_value = 0
export (int,0,1000000) var max_value = 1000000

func _ready():
	self.text = str(value)

func get_value()->int:
	return value

func set_value(new_value:int):
	value = new_value
	if value < min_value:
		value = min_value
	if value > max_value:
		value = max_value
	self.text = str(value)
	emit_signal("value_changed",value)

func _on_NumberImput_text_changed():
	set_value(int(self.text))

func _on_NumberImput_text_change_rejected():
	self.text = str(value)

func _on_NumberImput_text_entered(new_text):
	if new_text!="":
		set_value(int(new_text))
	else:
		self.text=str(value)

func _on_NumberImput_focus_exited():
	emit_signal("editing_stopped")
