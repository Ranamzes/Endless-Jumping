extends Button

signal play_pressed



func _on_pressed():
	emit_signal("play_pressed")
	get_node("../AnimationPlayer").play("FadeOut")
