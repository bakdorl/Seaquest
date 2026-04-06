extends Node2D

func _ready():
	AudioControllerMenu.stop_menu_music()
	AudioController.play_music()

func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	pass
