extends Node

var _pos = {
	"x": 0,
	"y": 0
}

var playerInstance
var posLabelInstance

func _ready():
	playerInstance = get_parent().get_parent().get_node("Player")
	playerInstance.connect("player_position_changed", _on_player_position_changed)
	

func _on_player_position_changed(new_position):
	_pos = new_position.floor()
	$posLabel.text = "X: " + str(_pos.x) + " Y: " + str(_pos.y)
