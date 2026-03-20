extends CharacterBody2D

@onready var projectile_scene = load ("res://projectile_scene.tscn")

signal oxygen_changed(value)
signal submarine_exploded
		
const SPEED = 450.0
var projectile_direction = Vector2(1.0, 0.0) 
var max_oxygen: float = 100.0
var current_oxygen: float = 100.0
var oxygen_speed: float = 2.5 
var is_dead = false

func _ready():
	$AnimatedSprite2D.play("default")


func _physics_process(_delta: float) -> void:
	
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
		projectile_direction.x = direction.x
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("left"):
		direction.x -= 1
		projectile_direction.x = direction.x
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
		
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
	position.x = clamp(global_position.x, 250, 1670)
	position.y = clamp(global_position.y, 255, 800)
	
func explode():
	is_dead = true 
	#$AnimatedSprite2D.play("explode")
	$CollisionShape2D.set_deferred ("disabled", true)
	velocity = Vector2.ZERO
	#await $AnimatedSprite2D.animation_finished
	queue_free()
	
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	var surface_y = 260
	if global_position.y <= surface_y:
		current_oxygen += (oxygen_speed * 8) * delta
	else:
		current_oxygen -= oxygen_speed * delta
		
	current_oxygen = clamp(current_oxygen, 0, max_oxygen)
	oxygen_changed.emit(current_oxygen)
	print(current_oxygen)
		
	#current_oxygen -= oxygen_speed * delta
	#oxygen_changed.emit(current_oxygen)
	if current_oxygen <= 0:
		explode()
	

func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.position = global_position
	projectile.direction.x = projectile_direction.x
	get_tree().current_scene.add_child(projectile)
	

	
	
	
	
	
