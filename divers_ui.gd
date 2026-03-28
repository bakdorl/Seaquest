extends CanvasLayer

@export var diver_icon_scene: PackedScene 
@onready var divers_container = $diversicon 

func _ready():
	divers_container.set_anchors_and_offsets_preset(Control.PRESET_CENTER_BOTTOM, Control.PRESET_MODE_KEEP_WIDTH)
	divers_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
	divers_container.position.y -= 50
	var submarine = get_tree().current_scene.find_child("Submarine", true, false)
	if submarine:
		submarine.divers_changed.connect(_on_divers_changed)
		_on_divers_changed(submarine.divers_collected)

func _on_divers_changed(current_count: int):
	for child in divers_container.get_children():
		child.queue_free()
	for i in range(current_count):
		if diver_icon_scene:
			var new_icon = diver_icon_scene.instantiate()
			divers_container.add_child(new_icon)
