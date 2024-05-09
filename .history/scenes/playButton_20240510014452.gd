extends Button

signal play_pressed
@onready print(get_tree().get_root().get_path_to(self))

func _on_pressed():
	emit_signal("play_pressed")
	get_node("../AnimationPlayer").play("FadeOut")
