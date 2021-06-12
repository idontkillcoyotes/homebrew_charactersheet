extends MarginContainer

func open():
	self.show()

func close():
	self.hide()

func _ready():
	self.hide()
	CharacterDataManager.connect("data_loaded",self,"_on_character_data_loaded")

func _on_character_data_loaded():
	open()

func _on_MenuBar_button_close_sheet_pressed():
	close()
