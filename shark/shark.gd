extends Area2D

@export var speed = 200.0
@export var amplitude = 20 #15.0  
@export var frequency = 4 #3.5   

var direction = -1 
var initial_y = 0.0
var time_passed = 0.0

func _ready():
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.flip_h = (direction == 1)
	add_to_group("enemies")
	initial_y = position.y

func _process(delta):
	position.x += speed * direction * delta
	time_passed += delta
	var wave = sin(time_passed * frequency) * amplitude
	position.y = initial_y + wave
	if position.x > 2000 or position.x < 1:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("projectiles"):
		area.queue_free()
		queue_free()
