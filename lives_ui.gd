extends CanvasLayer

@export var life_icon_scene: PackedScene 
@onready var lives_container = $HBoxContainer

func _ready():
	lives_container.set_anchors_and_offsets_preset(Control.PRESET_CENTER_TOP, Control.PRESET_MODE_KEEP_WIDTH)
	lives_container.alignment = BoxContainer.ALIGNMENT_CENTER
	lives_container.position.y = 85

	var submarine = get_tree().current_scene.find_child("Submarine", true, false)
	if submarine:
		submarine.lives_changed.connect(_on_lives_changed)
		_on_lives_changed(submarine.lives)

func _on_lives_changed(current_lives: int):
	for child in lives_container.get_children():
		child.queue_free()
	
	for i in range(current_lives):
		var new_icon = life_icon_scene.instantiate()
		lives_container.add_child(new_icon)
