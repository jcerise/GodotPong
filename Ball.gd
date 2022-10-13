extends Area2D

var speed = 200
var screen_size
var velocity
var trigger_bounce_x: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	velocity = Vector2(rand_range(0.0, 100.0), rand_range(0.0, 100.0))

func _process(delta):
	# Check if the ball is leaving the screen in any direction. If it is,
	# Simply reverse the velocity in relation to the axis the ball was leaving
	# the screen, which will create a very, very basic bouncing behavior
	if trigger_bounce_x or position.x >= screen_size.x or position.x <= 0:
		velocity = self.bounce_x(delta)
		self.trigger_bounce_x = false
		
	if position.y >= screen_size.y or position.y <= 0:
		velocity = self.bounce_y(delta)
		
	self.update_position(delta)


func _on_PlayerPaddle_area_entered(area):
	self.trigger_bounce_x = true
	
func _on_OpponentPaddle_area_entered(area):
	self.trigger_bounce_x = true
	
func bounce_x(delta) -> Vector2:
	return Vector2(-velocity.x, velocity.y)
	
func bounce_y(delta) -> Vector2:
	return Vector2(velocity.x, -velocity.y)
	
func update_position(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
