extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var play_button_path = "../menu/Control/play_button"
	var play_button = get_node_or_null(play_button_path)
	if play_button:
		play_button.connect("pressed", Callable (self, "_on_play_button_pressed"))
	else:
		print("Play button not found at path: ", play_button_path)

func _on_play_button_pressed():
	$AnimationPlayer.play("Move_camera_under_bridge")
