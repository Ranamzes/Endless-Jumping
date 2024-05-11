extends Button

signal play_pressed
@onready var name = get_node()
func _on_pressed():
	emit_signal("play_pressed")
	get_node("../AnimationPlayer").play("FadeOut")
