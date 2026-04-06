extends CharacterBody2D

@onready var projectile_scene = load ("res://projectile_scene.tscn")

signal oxygen_changed(value)
signal lives_changed(value)
signal divers_changed(count)
signal submarine_exploded

const SPEED = 450.0
const MAX_DIVERS: int = 6
const MAX_LIVES: int = 6
const SPAWN_POSITION = Vector2(960, 250)

var lives: int = 3
var projectile_direction = Vector2(1.0, 0.0) 
var max_oxygen: float = 100.0
var current_oxygen: float = 100.0
var oxygen_speed: float = 2.5 
var is_dead = false
var divers_collected: int = 0
var passive_state = false
var submerged = false
var removed_diver = false

func _ready():
	$AnimatedSprite2D.play("default")
	lives_changed.emit(lives)
	await get_tree().process_frame

func _physics_process(_delta: float) -> void:
	if passive_state == true or is_dead:
		return 
	
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
		projectile_direction.x = direction.x
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
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
	if is_dead: return
	is_dead = true
	lives -= 1
	lives_changed.emit(lives)
	deposit_divers()
	AudioController.play_death()
	$AnimatedSprite2D.play("explode")
	$CollisionShape2D.set_deferred ("disabled", true)
	velocity = Vector2.ZERO
	await $AnimatedSprite2D.animation_finished
	get_tree().call_group("spawner", "clear_all_entities")
	if lives > 0:
		respawn()
	else:
		game_over()
	
func _process(delta):
	if is_dead: return
	
	if Input.is_action_just_pressed("shoot"):
		AudioController.play_shoot()
		shoot()
	
	var surface_y = 260
	if global_position.y <= surface_y and divers_collected >= 1:
		passive_state = true 
		submerged = false
		process_refilling(delta)
	elif global_position.y <= surface_y and divers_collected < 1:
		if submerged == true:
			explode()
			submerged = false 
	else:
		current_oxygen -= oxygen_speed * delta
	
	if global_position.y > 270:
		submerged = true
		removed_diver = false
	
	current_oxygen = clamp(current_oxygen, 0, max_oxygen)
	oxygen_changed.emit(current_oxygen)
	
	if current_oxygen <= 0:
		explode()

func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.position = global_position
	projectile.direction.x = projectile_direction.x
	get_tree().current_scene.add_child(projectile)
	
func pick_up_diver():
	if divers_collected < MAX_DIVERS:
		divers_collected += 1
		divers_changed.emit(divers_collected)
	else:
		print("Submarine full")

func deposit_divers():
	if divers_collected > 0:
		divers_collected = 0
		divers_changed.emit(divers_collected)
	
func _on_collection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("divers"):
		AudioController.play_pickup_diver()
		pick_up_diver()
		area.queue_free()
	if area.is_in_group("enemies"):
		explode()
	if area.is_in_group("ProjectileEnemy"):
		explode()

func process_refilling(delta):
	if divers_collected < MAX_DIVERS:
		refill_oxygen(delta)
		if current_oxygen >= 100 and removed_diver == false:
			divers_collected -= 1
			removed_diver = true
			divers_changed.emit(divers_collected)
	else:
		handle_full_delivery()

func refill_oxygen(delta): 
	current_oxygen += (oxygen_speed * 15) * delta
	if current_oxygen >= 100:
		current_oxygen = 100.0 
		passive_state = false

func respawn():
	await get_tree().create_timer(0.5).timeout
	is_dead = false
	global_position = SPAWN_POSITION
	current_oxygen = max_oxygen
	divers_collected = 0
	submerged = false
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play("default")

func game_over():
	submarine_exploded.emit()
	divers_changed.emit(divers_collected)
	get_tree().change_scene_to_file("res://menu.tscn")
	queue_free()

func handle_full_delivery():
	if is_dead: return
	var delivery_bonus = 1000
	var oxygen_bonus = int(current_oxygen * 6.4)
	add_score(delivery_bonus + oxygen_bonus)
	passive_state = true
	divers_collected = 0 
	divers_changed.emit(divers_collected)
	if lives < MAX_LIVES:
		get_tree().call_group("spawner", "clear_all_entities")
		lives += 1
		lives_changed.emit(lives)
	velocity = Vector2.ZERO
	await get_tree().create_timer(1.0).timeout 
	passive_state = false
	current_oxygen = 100.0

func add_score(amount: int):
	GameState.player_score += amount
	#score_changed.emit(score)
	if int(GameState.player_score / 10000) > int((GameState.player_score - amount) / 10000):
		give_extra_life()

func give_extra_life():
	if lives < MAX_LIVES:
		lives += 1
		lives_changed.emit(lives)
		
		
		
