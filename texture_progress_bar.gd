extends TextureProgressBar


func _on_submarine_oxygen_changed(new_value):
	print("oxygen is now: ", new_value)
	self.value = new_value
