extends TextureRect


func _on_play_button_play_pressed():
	print("play_clicked")
	$AnimationPlayer.play("FadeOut")
