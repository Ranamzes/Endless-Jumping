extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
    $menu/play_button.connect("play_pressed", self, "_on_play_button_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
