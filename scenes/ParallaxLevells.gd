extends ParallaxBackground

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(_delta):
# 	var layers = get_children() # Получить все дочерние слои
# 	var camera = get_node_or_null("root/WorldEnvironment/main/Camera2D") # Правильное обращение к камере
# 	var camera_y = camera.global_position.y # Корректное получение глобальной позиции камеры

# 	for parallax_layer in layers:
# 		if parallax_layer is ParallaxLayer:
# 			# Убедитесь, что у parallax_layer есть текстура перед вызовом get_height()
# 			if parallax_layer.texture:
# 				var layer_bottom = parallax_layer.global_position.y + parallax_layer.texture.get_height()
# 				# Проверяем, находится ли нижняя часть слоя выше камеры
# 				if layer_bottom < camera_y:
# 					parallax_layer.z_index = 100 # Переместить слой на передний план
# 				else:
# 					parallax_layer.z_index = 0 # Обычное положение
