extends Area2D

var speed = 200
var screen_size
var velocity


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	velocity = Vector2(rand_range(0.0, 100.0), rand_range(0.0, 100.0))

func _process(delta):
	# Check if the ball is leaving the screen in any direction. If it is,
	# Simply reverse the velocity in relation to the axis the ball was leaving
	# the screen, which will create a very, very basic bouncing behavior
	if position.x >= screen_size.x or position.x <= 0:
		velocity = Vector2(-velocity.x, velocity.y)
		
	if position.y >= screen_size.y or position.y <= 0:
		velocity = Vector2(velocity.x, -velocity.y)
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
