extends Area2D


const SWIM_SPEED = 100.0
var direction = 1 # 1 for Right, -1 for Left

func _process(delta):
	position.x += SWIM_SPEED * direction * delta
	$AnimatedSprite2D.flip_h = direction < 0
	if global_position.x > 2000 or global_position.x < -100:
		queue_free()
