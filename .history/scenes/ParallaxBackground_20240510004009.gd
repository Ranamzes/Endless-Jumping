extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
    var camera = get_node("Camera2D")
    set_current_camera(camera)
