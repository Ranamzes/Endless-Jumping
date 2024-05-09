extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
    var camera = get_node("Camera2D")  # Adjust path as necessary
    set_current_camera(camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
