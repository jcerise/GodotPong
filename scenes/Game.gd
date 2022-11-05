extends Node

const BallResource = preload("res://scenes/Ball.tscn")

var player_score
var opponent_score

# Called when the node enters the scene tree for the first time.
func _ready():
	player_score = 0
	opponent_score = 0
	randomize()
	
func new_game():
	player_score = 0
	opponent_score = 0

func _on_Ball_player_score():
	player_score += 1
	$HUD.update_player_score(player_score)

func _on_Ball_opponent_score():
	opponent_score += 1
	$HUD.update_opponent_score(opponent_score)
