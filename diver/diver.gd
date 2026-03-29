extends Area2D


const SWIM_SPEED = 100.0
const DETECTION_RANGE = 100.0
const PANIC_SPEED = 250.0

var is_scared = false

var direction = 1 


func _ready():
	if is_scared:
		if $AnimatedSprite2D.animation != "scared":
			$AnimatedSprite2D.play("scared")
	else:
		if $AnimatedSprite2D.animation != "defaultdiver":
			$AnimatedSprite2D.play("defaultdiver")


func _process(delta):
	var current_speed = SWIM_SPEED
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < DETECTION_RANGE:
			is_scared = true
			var direction_to_enemy = (enemy.global_position.x - global_position.x)
			if direction_to_enemy > 0 and direction == 1:
				direction = -1
			elif direction_to_enemy < 0 and direction == -1:
				direction = 1
			break
	if is_scared:
		current_speed = PANIC_SPEED
		if $AnimatedSprite2D.animation != "scared":
			$AnimatedSprite2D.play("scared")
	else:
		current_speed = SWIM_SPEED
		if $AnimatedSprite2D.animation != "defaultdiver":
			$AnimatedSprite2D.play("defaultdiver")
	position.x += current_speed * direction * delta
	$AnimatedSprite2D.flip_h = direction < 0
	if global_position.x > 2000 or global_position.x < -100:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass
