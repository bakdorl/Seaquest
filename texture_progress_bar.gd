extends TextureProgressBar

var original_color: Color
var is_low_oxygen: bool = false
var blink_timer: float = 0.0
var blink_frequency: float = 0.2 

func _ready():
	original_color = self.tint_progress

func _on_submarine_oxygen_changed(new_value):
	self.value = new_value
	var oxygen_percentage = (new_value / float(self.max_value)) * 100
	if oxygen_percentage <= 30:
		is_low_oxygen = true
	else:
		is_low_oxygen = false
		self.tint_progress = original_color 

func _process(delta):
	if is_low_oxygen:
		blink_timer += delta
		if blink_timer >= blink_frequency:
			blink_timer = 0.0
			if self.tint_progress == original_color:
				self.tint_progress = Color(1, 0, 0) 
			else:
				self.tint_progress = original_color
