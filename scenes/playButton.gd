extends Button

signal play_pressed

func _ready():
	# Убедитесь, что кнопка может получать фокус для ввода.
	set_focus_mode(FOCUS_ALL)
	# Слушаем сигнал нажатия кнопки
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
	emit_signal("play_pressed")
	get_node("../AnimationPlayer").play("FadeOut")
