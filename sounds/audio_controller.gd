extends Node2D

#func _ready():
	#play_music()

func play_music():
	$music.play()

func play_shoot() -> void:
	$shoot.play()

func play_death() -> void:
	$death.play()

func play_refill() -> void:
	$refill.play()

func play_pickup_diver() -> void:
	$pickup_diver.play()

func play_alarm() -> void:
	$alarm.play()

func stop_music():
	$music.stop()
