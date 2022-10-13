extends Area2D


var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

	
func _process(delta):
	var ball_node = get_tree().get_root().find_node("Ball", true, false)

	var velocity: Vector2 = Vector2.ZERO
	
	if ball_node.position.y > position.y:
		velocity.y += 1
	elif ball_node.position.y < position.y:
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.y = clamp(
		position.y, 
		$CollisionShape2D.get_shape().height / 2, 
		screen_size.y - $CollisionShape2D.get_shape().height / 2
	)

