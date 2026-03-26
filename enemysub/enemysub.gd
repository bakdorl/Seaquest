extends Area2D

@onready var projectileenemy_scene = load ("res://enemysub/projectileenemy.tscn")

@export var speed = 200.0
var direction = -1 
var shoot_timer = Timer.new()


func _ready():
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.flip_h = (direction == 1)
	add_to_group("enemies")
	add_child(shoot_timer)
	shoot_timer.wait_time = 1.0
	shoot_timer.timeout.connect(_on_shoot_timeout)
	shoot_timer.start()

func _process(delta):
	position.x += speed * direction * delta
	
	if position.x > 2000 or position.x < 1:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("projectiles"):
		area.queue_free()
		queue_free()

func _on_shoot_timeout():
	if position.x > 300 and position.x < 1600:
		spawn_projectileenemy(-10) 
		spawn_projectileenemy(10)  
	

func spawn_projectileenemy(y_offset: float):
	if projectileenemy_scene:
		var p_enemy = projectileenemy_scene.instantiate()
		get_tree().current_scene.add_child(p_enemy)
		p_enemy.z_index = -1 
		p_enemy.global_position = global_position + Vector2(0, y_offset)
		if p_enemy.has_method("set_direction"):
			p_enemy.set_direction(direction)
		p_enemy.top_level = true
		
