extends Node2D

# Preload levels
var level_1_1 = preload("res://scenes/levels/1/level_1_1.tscn")
var level_1_2 = preload("res://scenes/levels/1/level_1_2.tscn")
var level_1_3 = preload("res://scenes/levels/1/level_1_3.tscn")
var levels_1 := [level_1_1, level_1_2, level_1_3]

var levels : Array

var score : int
var SCORE_MODIFIER : int = 100
const START_SPEED : int = 250
const SPEED_MODIFIER : int = 2000
const MAX_SPEED : int = 550
var speed : float
var game_running : bool = false

var lastLoadedLevel : CharacterBody2D 

var screen_size : Vector2i

@onready var scoreLabel = $HUD.get_node("ScoreLabel")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = START_SPEED + score / SPEED_MODIFIER
	if speed > MAX_SPEED:
		speed = MAX_SPEED
		
	score += speed
	show_score()
	
	load_next_level()
	
	for _level in levels :
		_level.velocity.y = speed * -1
		_level.move_and_slide()
		if _level.position.y < screen_size.y * -1 :
			print("removed " + str(_level.position.y))
			levels.remove_at(0)
			_level.queue_free()


func new_game():
	# Reset variables 
	score = 0

func show_score():
	scoreLabel.text = " Score: " + str(score / SCORE_MODIFIER)
	
func load_next_level():
	if levels.size() < 1 || lastLoadedLevel.position.y < 0:
		var level_number = levels_1[randi() % levels_1.size()]
		var level = level_number.instantiate()
		
		level.position = Vector2i(0, screen_size.y - 5)
			
		print(level.position.y)
		add_child(level)
		lastLoadedLevel = level
		levels.append(level)
