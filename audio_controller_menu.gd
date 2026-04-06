extends Node2D

func play_menu_music() -> void:
	$menu_music.play()

func play_button_sound() -> void:
	$button_sound.play()
	
func stop_menu_music() -> void:
	$menu_music.stop()
