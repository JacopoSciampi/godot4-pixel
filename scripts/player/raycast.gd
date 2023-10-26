extends RayCast2D

var player
var messageScene = preload("res://scenes/ui/messageFromObject.tscn")
var messageInstance
var collider

func _ready():
	player = get_parent()
	
func _process(_delta):
	if is_colliding():
		collider = get_collider()
		
		if (collider.recastableType == "OBJECT") && messageInstance == null:
			var msg = collider.getMessage()
			var objectPosition = collider.position
			
			messageInstance = messageScene.instantiate()
			var messageNode = messageInstance.get_node("message")
			messageNode.text = msg
			messageInstance.position = Vector2(objectPosition.x -25 +8 , objectPosition.y + 10)
			get_tree().get_root().add_child(messageInstance)
		elif (collider.recastableType == "PICKABLE") && messageInstance == null:
			var msg = collider.getMessage()
			var objectPosition = collider.position
			
			messageInstance = messageScene.instantiate()
			var messageNode = messageInstance.get_node("message")
			messageNode.text = msg
			messageInstance.position = Vector2(objectPosition.x -25 +8 , objectPosition.y + 10)
			get_tree().get_root().add_child(messageInstance)
			
		if collider.has_method("onPickup") && Input.is_action_pressed("pickup"):
			collider.onPickup()
			collider.queue_free()
			
	else:
		if messageInstance != null:
			messageInstance.queue_free()
			messageInstance = null
