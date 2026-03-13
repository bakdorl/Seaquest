extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta: float) -> void:
	
<<<<<<< HEAD
=======
	
>>>>>>> 9f1fbaead46009aee4990b5a10ff7c3f2bb42625
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
<<<<<<< HEAD
		$Sprite2D.flip_h = false
	if Input.is_action_pressed("left"):
		direction.x -= 1
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
=======
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
>>>>>>> 9f1fbaead46009aee4990b5a10ff7c3f2bb42625
		
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
