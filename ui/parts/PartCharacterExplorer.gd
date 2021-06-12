extends Control

signal closed

onready var btn_edit = $VBoxContainer/Buttons/Box/ButtonEdit
onready var btn_delete =$VBoxContainer/Buttons/Box/ButtonDelete
onready var list = $VBoxContainer/MarginContainer2/CharacterList

func open():
	self.show()
	list.reload()

func close():
	self.hide()
	emit_signal("closed")

func _ready():
	self.hide()

func _on_ButtonClose_pressed():
	close()

func _on_CharacterList_selected_item(idx):
	CharacterDataManager.load_character(idx)
	close()


func _on_MenuCharacter_button_load_pressed():
	open()
