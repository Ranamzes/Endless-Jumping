extends CharacterBody2D

const SPEED = 300.0

@onready var sprite: = $AnimatedSprite2D


func _physics_process(delta):

	if get_parent().game_over :
		return
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x > 0:
		sprite.scale.x = -1
	elif velocity.x < 0:
		sprite.scale.x = 1
		
	move_and_slide()

func player_die():
	get_parent().game_over = true
