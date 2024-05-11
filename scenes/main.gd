extends Node2D

func _input(event):
	if Globals.can_play and (event is InputEventScreenTouch or event is InputEventKey) and event.pressed:
		$AnimationPlayer.play("Move_camera_to_start")
		Globals.can_play = false

func add_scene_and_trigger_method():
	var scene_resource = load("res://scenes/game.tscn")
	if scene_resource == null:
		print("Failed to load scene resource. Check the path.")
		return

	if not scene_resource is PackedScene:
		print("Loaded resource is not a PackedScene.")
		return

	var scene_instance = scene_resource.instantiate()
	if not scene_instance:
		print("Failed to instantiate the scene.")
		return

	var target_node = get_tree().root.get_node("WorldEnvironment/main")
	if not target_node:
		print("Target node not found.")
		return

	target_node.add_child(scene_instance)
	print("Scene loaded and method called successfully.")
	scene_instance.start_level()
