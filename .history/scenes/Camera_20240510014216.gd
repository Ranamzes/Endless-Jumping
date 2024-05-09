extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$../menu/Control/play_button.connect("play_pressed", Callable(self, "_on_play_button_pressed"))

func _on_play_button_pressed():
	$AnimationPlayer.play("Move_camera_under_bridge")
