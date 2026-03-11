extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta: float) -> void:
	
	
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
		print("right")
	if Input.is_action_pressed("left"):
		direction.x -= 1
		print("left")
	if Input.is_action_pressed("down"):
		direction.y += 1
		print("down")
	if Input.is_action_pressed("up"):
		direction.y -= 1
		print("up")
		
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
