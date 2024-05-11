extends Node

var save_path = "user://game_state.save"

# Function to save the game state
func save_game():
	var root_node = get_tree().root.get_node("WorldEnvironment")
	var save_data = {}
	_save_node_state(root_node, save_data)

	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		var json_text = JSON.stringify(save_data)
		file.store_string(json_text)
		file.close()
		# print("Game saved successfully.")
	else:
		print("Failed to save game.")

# Recursive function to save node states
func _save_node_state(node, save_data):
	var node_data = {}
	var property_list = node.get_property_list()
	for property in property_list:
		if property.usage&PROPERTY_USAGE_STORAGE:
			var current_value = node.get(property.name)
			var default_value = node.get_script().get_property_default_value(property.name) if node.get_script() else current_value
			if current_value != default_value:
				node_data[property.name] = current_value

	if node is ParallaxBackground:
		node_data["scroll_offset"] = node.scroll_offset # Saving scroll_offset for ParallaxBackground

	if node_data:
		save_data[node.get_path()] = node_data

	for child in node.get_children():
		_save_node_state(child, save_data)

# Function to load the game state
func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var json = JSON.new() # Create a new JSON instance
		var error = json.parse(json_text) # Use the instance to parse the JSON text

		if error == OK:
			var save_data = json.get_data() # Retrieve the parsed data
			_load_node_state(get_tree().root.get_node("WorldEnvironment"), save_data)
			# print("Game loaded successfully.")
			_trigger_post_load_animation()
		else:
			print("JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())

		file.close()
	else:
		print("Failed to load game.")

func _trigger_post_load_animation():
	var animation_player = get_tree().root.get_node("WorldEnvironment/main/AnimationPlayer") # Adjust path as necessary
	Globals.can_play = true
	if animation_player:
		animation_player.play("Move_camera_under_bridge")
	else:
		print("AnimationPlayer not found.")

func _load_node_state(node, save_data):
	var node_path = node.get_path()
	if save_data.has(node_path):
		var node_data = save_data[node_path]
		for property in node_data.keys():
			node.set(property, node_data[property])
			if node is ParallaxBackground and "scroll_offset" in node_data:
				node.scroll_offset = node_data["scroll_offset"]

	for child in node.get_children():
		_load_node_state(child, save_data)
