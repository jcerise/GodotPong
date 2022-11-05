extends CanvasLayer


signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_player_score(score):
	$PlayerScore.text = str(score)
	
func update_opponent_score(score):
	$OpponentScore.text = str(score)
