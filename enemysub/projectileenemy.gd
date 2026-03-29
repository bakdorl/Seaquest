extends Area2D


var speed = 600.0 
var move_dir = -1  


func set_direction(dir):
	move_dir = dir

func _physics_process(delta):
	position.x += speed * move_dir * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass
	
