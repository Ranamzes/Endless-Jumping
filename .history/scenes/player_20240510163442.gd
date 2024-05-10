extends CharacterBody2D

@export var MIN_SPEED = 250.0
@export var MAX_SPEED = 450.0
@export var ACCELERATION = 250.0
var currentSpeed = MIN_SPEED
var deltaSpeed = 0
var prev_direction = 0

@onready var sprite: = $AnimatedSprite2D


func _physics_process(delta):

	if get_parent().game_over :
		return

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		if direction != prev_direction :
			deltaSpeed = 0
		deltaSpeed += delta * ACCELERATION
		currentSpeed = min(MIN_SPEED + deltaSpeed, MAX_SPEED)
		velocity.x = currentSpeed * direction
		prev_direction = direction
	else:
		currentSpeed = move_toward(currentSpeed, MIN_SPEED, ACCELERATION * delta)
		velocity.x = move_toward(velocity.x, 0, currentSpeed * delta)
		prev_direction = 0

	#print(velocity.x)

	# Отражение спрайта в зависимости от направления движения
	sprite.scale.x = -1 if velocity.x > 0 else 1 if velocity.x < 0 else sprite.scale.x

	move_and_slide()

func player_die():
	get_parent().game_over = true
