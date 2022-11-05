extends Area2D

var speed = 130
var screen_size
var velocity
var trigger_bounce_x: bool

signal player_score
signal opponent_score


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	velocity = Vector2(rand_range(0.0, 100.0), rand_range(0.0, 100.0))

func _process(delta):
	# Check if the ball is leaving the screen in any direction. If it is,
	# Simply reverse the velocity in relation to the axis the ball was leaving
	# the screen, which will create a very, very basic bouncing behavior
	if trigger_bounce_x:
		velocity = self.bounce_x(delta)
		self.trigger_bounce_x = false
		
	if position.y >= screen_size.y or position.y <= 0:
		velocity = self.bounce_y(delta)
		
	if position.x <= 0:
		emit_signal("opponent_score")
		reset_position()
	elif position.x >= screen_size.x:
		emit_signal("player_score")
		reset_position()
		
	self.update_position(delta)

func _on_PlayerPaddle_area_entered(area):
	self.trigger_bounce_x = true
	
func _on_OpponentPaddle_area_entered(area):
	self.trigger_bounce_x = true
	
func _on_VisibilityNotifier2D_screen_exited():
	if position.x <= 0:
		emit_signal("player_score")
	elif position.x >= screen_size.x:
		emit_signal("opponent_score")
	reset_position()
	
func bounce_x(delta) -> Vector2:
	return Vector2(-velocity.x, velocity.y)
	
func bounce_y(delta) -> Vector2:
	return Vector2(velocity.x, -velocity.y)
	
func update_position(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta

func reset_position():
	position.x = screen_size.x / 2
	position.y = screen_size.y / 2
