extends Area2D

@export var speed = 200.0
var direction = -1 

func _ready():
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.flip_h = (direction == 1)
	add_to_group("enemies")

func _process(delta):
	position.x += speed * direction * delta
	
	if position.x > 2000 or position.x < 1:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("projectiles"):
		GameState.player_score += 20
		area.queue_free()
		queue_free()
