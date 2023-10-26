extends CharacterBody2D

var speed
var currentDirection = "none"
var lastDirection = "down"
var raycastDirection = {
	"x": 0,
	"y": 20
}

signal player_position_changed(Vector2)

func _physics_process(delta):
	playerMovement(delta)
	
func _ready():
	$AnimatedSprite2D.play("frontIdle")
	
func playerMovement(_delta):
	speed = 150 if Input.is_action_pressed("sprint") else 100
	
	if Input.is_action_pressed("right"):
		movePlayer(speed, 0, "right", true)
	elif Input.is_action_pressed("left"):
		movePlayer(-speed, 0, "left", true)
	elif Input.is_action_pressed("down"):
		movePlayer(0, speed, "down", true)
	elif Input.is_action_pressed("up"):
		movePlayer(0, -speed, "up", true)
	else:
		movePlayer(0, 0, "none", false)
		
func playAnimation(isMoving):
	var anim = $AnimatedSprite2D
	
	if(isMoving):
		lastDirection = currentDirection
	
		if currentDirection == "right" || currentDirection == "left":
			anim.flip_h = currentDirection == "left"
			anim.play("sideWalk")
				
		elif currentDirection == "up" || currentDirection == "down":
			anim.play("frontWalk" if currentDirection == "down" else "backWalk")
	else:
		anim.flip_h = lastDirection == "left"
		var animToPlay = "sideIdle"
		
		if lastDirection == "up": 
			animToPlay = "backIdle"
		elif lastDirection == "down":
			animToPlay = "frontIdle"
			
		anim.play(animToPlay)
		
func movePlayer(xDir, yDir, newDirection, isMoving):
	currentDirection = newDirection
	velocity.x = xDir
	velocity.y = yDir
	
	raycastDirection = {
		"x": -20 if lastDirection == "left" else 20 if lastDirection == "right" else 0,
		"y": -20 if lastDirection == "up" else 20 if lastDirection == "down" else 0
	}
	
	$Raycast.target_position = Vector2(raycastDirection.x, raycastDirection.y)
	move_and_slide()
		
	playAnimation(isMoving)
	
	emit_signal("player_position_changed", global_position)
