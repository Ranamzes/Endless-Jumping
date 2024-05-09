
extends Button

signal play_pressed

func _on_pressed():
	emit_signal("play_pressed")
	get_node("../AnimationPlayer").play("FadeOut")
>>>>>>> 303a2b2e6d70ae8ed2c3c00b39dcca34e44db834
