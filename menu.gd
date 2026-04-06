extends Node2D

func _ready():
	AudioController.stop_music()
	AudioControllerMenu.play_menu_music()

func _on_start_pressed() -> void:
	AudioControllerMenu.play_button_sound()
	get_tree().change_scene_to_file("res://ocean.tscn")


func _on_quit_pressed() -> void:
	AudioControllerMenu.play_button_sound()
	get_tree().quit()
