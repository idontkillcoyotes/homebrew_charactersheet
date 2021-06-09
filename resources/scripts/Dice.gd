extends Resource
class_name Dice

export (int,2,100) var sides = 20

func _init(_sides:int):
	sides = _sides

func roll()->int:
	randomize()
	return ((randi()%sides)+1)
