extends TextureRect


func _on_play_button_play_pressed():
	print("play_clicked")
	get_node($AnimationPlayer).play("FadeOut")
