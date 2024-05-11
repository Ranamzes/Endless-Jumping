extends CharacterBody2D

@export var MIN_SPEED = 100.0
@export var MAX_SPEED = 450.0
@export var ACCELERATION = 70.0
var currentSpeed = MIN_SPEED
var time = 0.0
var accelerating = false
var prev_direction = 0

@onready var sprite := $AnimatedSprite2D

	
func _physics_process(delta):

	if get_parent().game_over:
		return

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		if not accelerating or direction != prev_direction:
			time = 0.0 # Сброс таймера при смене направления или начале движения
			accelerating = true

		time += delta
		var t = min(time / 1.0, 1.0) # Ограничение времени ускорения
		var ease_value = t * t * (3.0 - 2.0 * t) # Применение кубической ease-in-out функции
		currentSpeed = lerp(MIN_SPEED, MAX_SPEED, ease_value)
		velocity.x = currentSpeed * direction
		prev_direction = direction
	else:
		accelerating = false
		currentSpeed = move_toward(currentSpeed, MIN_SPEED, ACCELERATION * delta)
		velocity.x = move_toward(velocity.x, 0, currentSpeed * delta)

	#print(velocity.x)

	# Отражение спрайта в зависимости от направления движения
	sprite.scale.x = -1 if velocity.x > 0 else 1 if velocity.x < 0 else sprite.scale.x

	move_and_slide()

func player_die():
	get_parent().game_over = true
