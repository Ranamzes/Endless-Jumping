extends Camera2D

func _ready():
	print(get_tree().get_root().get_path_to(self))
# Called when the node enters the scene tree for the first time.
# func _ready():
# 	$menu/play_button.connect("play_pressed", Callable(self, "_on_play_button_pressed"))
# func _on_play_button_pressed():
# 	$AnimationPlayer.play("Move_camera_under_bridge")
