extends Node2D

var highScoreSprite = preload ("res://scenes/high_score.tscn")
var gameOverScene = preload ("res://scenes/game_over_scene.tscn")
# Preload levels
var level_1_1 = preload ("res://scenes/levels/1/level_1_1.tscn")
var level_1_2 = preload ("res://scenes/levels/1/level_1_2.tscn")
var level_1_3 = preload ("res://scenes/levels/1/level_1_3.tscn")
var level_1_4 = preload ("res://scenes/levels/1/level_1_4.tscn")
var level_1_5 = preload ("res://scenes/levels/1/level_1_5.tscn")
var level_1_6 = preload ("res://scenes/levels/1/level_1_6.tscn")
var levels_1 := [level_1_1, level_1_2, level_1_3, level_1_4, level_1_5, level_1_6]

var levels: Array

var score: int
var highScoreScene: CharacterBody2D = null
const SCORE_MODIFIER: int = 100
const START_SPEED: int = 250
const SPEED_MODIFIER: int = 2000
const MAX_SPEED: int = 550
var speed: float
var game_running: bool = false
var game_over: bool = false
var was_record: bool = true
var game_paused: bool = false

var lastLoadedLevel: CharacterBody2D

var screen_size: Vector2i

@onready var scoreLabel = $HUD.get_node("ScoreLabel")
@onready var gameOverLabel = $HUD.get_node("GameOverLabel")
@onready var player = $player
@onready var playerStartPosition = player.position
@onready var parallax_levels = get_node("../../main/ParallaxLevels")

# Called when the node enters the scene tree for the first time.
func _ready():
	if parallax_levels:
		print("ParallaxLevels found at: ", parallax_levels.get_path())
	else:
		print("ParallaxLevels not found, check the node path.")
	screen_size = get_window().size
	set_process_input(true)

func prepare_player_start_animation():
	var start_position = Vector2(349, -100) # Начальная позиция вне экрана
	var end_position = Vector2(349, 422) # Конечная позиция на экране

	player.position = start_position

	# Создание Tween и настройка анимации свойства position
	var tween = get_tree().create_tween()
	var tweener = tween.tween_property(player, "position", end_position, 1.5)

	# Устанавливаем смягчение и переход для конкретного tweener
	tweener.set_ease(Tween.EASE_OUT) # Устанавливаем смягчение, чтобы движение замедлялось к концу
	tweener.set_trans(Tween.TRANS_QUAD)

func start_level():
	player.position = playerStartPosition
	player.velocity = Vector2(0, 0)
	prepare_player_start_animation()
	score = 0
	speed = START_SPEED

	# Очистка предыдущих уровней
	for level in levels:
		level.queue_free()
	levels.clear()

	# Загрузка следующего уровня
	load_next_level()
	show_score()

	# Установка процесса ввода, если он отключен
	set_process_input(true)
	game_running = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_paused:
		return
	if !game_running:
		if game_over:
			#game over here!
			if score > Globals.high_score:
				Globals.high_score = score

			was_record = false
			if highScoreScene != null:
				remove_high_score_image()

			var gos = gameOverScene.instantiate()
			gos.position = Vector2i(0, 0)
			add_child(gos)
			game_over = false
		return

	speed = START_SPEED + floor(score) / SPEED_MODIFIER
	if speed > MAX_SPEED:
		speed = MAX_SPEED

	if !game_over:
		score += speed

		show_score()

	show_high_score_image()

	if parallax_levels:
		update_parallax_scroll()
	else:
		print("Cannot update parallax scroll, ParallaxLevels is null.")

	load_next_level()

	if game_over:
		player.velocity.y = speed * - 1
		player.velocity.x = 0
		player.move_and_slide()

		if highScoreScene != null&&highScoreScene.position.y < 0:
			remove_high_score_image()

		if player.position.y < - 100:
			game_running = false

	if highScoreScene != null:
		highScoreScene.velocity.y = speed * - 1
		highScoreScene.move_and_slide()

	for _level in levels:
		_level.velocity.y = speed * - 1
		_level.move_and_slide()
		if _level.position.y < screen_size.y * - 1:
			levels.remove_at(0)
			_level.queue_free()

func new_game():
	# Reset variables
	score = 0

func show_score():
	#warning-ignore:integer_division
	scoreLabel.text = " Score: " + str(floor(score) / SCORE_MODIFIER)

func load_next_level():
	if levels.size() < 1||lastLoadedLevel.position.y < 0:
		var level_number = levels_1[randi() % levels_1.size()]
		var level = level_number.instantiate()

		level.position = Vector2i(0, screen_size.y - 5)

		#print(level.position.y)
		add_child(level)
		lastLoadedLevel = level
		levels.append(level)

func show_high_score_image():
	if score > Globals.high_score - speed * 200&&was_record == false:
		highScoreScene = highScoreSprite.instantiate()
		highScoreScene.position = Vector2i(screen_size.x + 10, screen_size.y - 5)
		add_child(highScoreScene)
		was_record = true

func remove_high_score_image():
	highScoreScene.queue_free()
	highScoreScene = null

func update_parallax_scroll():
	# Adjust the y offset based on the score
	var offset_change_rate = 0.02 # Lower this to reduce the change rate
	var damping_factor = 0.001 # Adds damping as the score increases
	var max_increment_per_frame = 3.0 # Maximum offset change per frame

	var calculated_increment = (score * offset_change_rate) / (1 + score * damping_factor)
	calculated_increment = min(calculated_increment, max_increment_per_frame)

	parallax_levels.scroll_base_offset.y -= calculated_increment
