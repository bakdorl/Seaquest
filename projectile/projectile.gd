extends Area2D

signal enemy_hit(score)

@export var speed = 2000
var direction = Vector2.ZERO

func _process(delta):
	position.x += speed * delta * direction.x

#func _on_area_entered(area: Area2D) -> void:
	#if area.is_in_group("enemies"):
		##var player = get_tree().get_first_node_in_group("player")
		##if player:
			##player.add_score(20) 
		#enemy_hit.emit(20)
		#area.queue_free() 
		#queue_free()      
		
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass
