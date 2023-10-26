extends Node

const recastableType = "PICKABLE"
@export var obj_id : String

func getMessage():
	return "Press F to pickup " + "\n" +  obj_id
	
func onPickup():
	print("Picked up")
