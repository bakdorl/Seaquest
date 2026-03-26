extends Node2D

@onready var shark_scene = preload("res://shark.tscn")
@onready var enemysub_scene = preload("res://enemysub.tscn")
const LANES = [345, 490, 635, 780] 


var lane_active = [false, false, false, false]

func _ready():
	spawn_logic_loop()
	
func spawn_logic_loop():
	var available_indices = []
	for i in range(4):
		if not lane_active[i]:
			available_indices.append(i)
	available_indices.shuffle()
	var num_to_attempt = randi_range(1, 2)
	for i in range(min(num_to_attempt, available_indices.size())):
		var idx = available_indices[i]
		if not lane_active[idx]:
			process_lane_spawn(idx) 
	await get_tree().create_timer(randf_range(3.0, 5.0)).timeout
	spawn_logic_loop()

func process_lane_spawn(lane_idx):
	lane_active[lane_idx] = true
	var y_pos = LANES[lane_idx]
	var dir = 1 if randf() > 0.5 else -1
	var spawn_x = 10 if dir == 1 else 1999
	var enemy_type = shark_scene if randf() > 0.5 else enemysub_scene
	var count = 1
	var roll = randf()
	if roll < 0.65: 
		count = 1
	elif roll < 0.90: 
		count = 2
	else: 
		count = 3
	for i in range(count):
		create_enemy(enemy_type, spawn_x, y_pos, dir)
		await get_tree().create_timer(0.8).timeout
	await get_tree().create_timer(5.0).timeout
	lane_active[lane_idx] = false
	
func create_enemy(scene, x, y, dir):
	var e = scene.instantiate()
	e.position = Vector2(x, y)
	if "direction" in e:
		e.direction = dir
	add_child(e)
	
	
