extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
    $menu/play_button.connect("play_pressed", Callable(self, "_on_play_button_pressed"))
