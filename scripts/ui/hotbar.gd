extends Node2D

var selectedSlot = 0

func _process(_delta):
	#Input 1-6 to be removed since they'll be used for spells
	if Input.is_action_pressed("1key"):
		selectedSlot = 1
	elif Input.is_action_pressed("2key"):
		selectedSlot = 2
	elif Input.is_action_pressed("3key"):
		selectedSlot = 3
	elif Input.is_action_pressed("4key"):
		selectedSlot = 4
	elif Input.is_action_pressed("5key"):
		selectedSlot = 5
	elif Input.is_action_pressed("6key"):
		selectedSlot = 6
	elif Input.is_action_just_released("wheelScrollUp"): 
		selectedSlot -= 1
		if selectedSlot < 1:
			selectedSlot = 6
	elif Input.is_action_just_released("wheelScrollDown"): 
		selectedSlot += 1
		if selectedSlot > 6:
			selectedSlot = 1
		
	_moveActiveSquare()
	
func _moveActiveSquare():
	if selectedSlot != null && selectedSlot != 0:
		get_node("selected").position = Vector2(selectedSlot * 64 - 32, 32)
