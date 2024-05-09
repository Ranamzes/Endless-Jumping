extends TextureRect


func _on_play_button_play_pressed():
	print("button_clicked")
	$AnimationPlayer.play("FadeOut")
