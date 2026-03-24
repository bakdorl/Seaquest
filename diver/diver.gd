extends Area2D


const SWIM_SPEED = 100.0
var direction = 1 

func _ready():
	$AnimatedSprite2D.play("defaultdiver")

func _process(delta):
	position.x += SWIM_SPEED * direction * delta
	$AnimatedSprite2D.flip_h = direction < 0
	if global_position.x > 2000 or global_position.x < -100:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass
