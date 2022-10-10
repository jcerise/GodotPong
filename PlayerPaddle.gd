extends Node2D

var speed = 400
var screen_size

# Signifies when the ball connects with the players paddle. Will cause
# a bounce to occur
signal ball_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.y = clamp(
		position.y, 
		$CollisionShape2D.get_shape().height / 2, 
		screen_size.y - $CollisionShape2D.get_shape().height / 2
	)
