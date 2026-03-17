extends CharacterBody2D

@onready var projectile_scene = load ("res://projectile_scene.tscn")

const SPEED = 450.0
var projectile_direction = Vector2(1.0, 0.0) 
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
	
	
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.position = global_position
	projectile.direction.x = projectile_direction.x
	get_tree().current_scene.add_child(projectile)
	
	
	
	
	
