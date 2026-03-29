extends CanvasLayer

@export var number_images: Array[Texture2D] 
@onready var digit_displays = $HBoxContainer.get_children()

func _ready():
	update_display(0)
	
func _process(delta: float) -> void:
	update_display(GameState.player_score)

func update_display(new_score: int):
	var display_score = min(new_score, 999999)
	var score_text = str(display_score).pad_zeros(6)
	
	for i in range(6):
		var digit_char = score_text[i]     
		var digit_int = int(digit_char)   
		digit_displays[i].texture = number_images[digit_int]
