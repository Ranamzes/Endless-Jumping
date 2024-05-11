extends Node2D

@onready var scoreLabel = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	scoreLabel.text = str(Globals.high_score)


func _on_button_pressed():
	GameManager.load_game()
	self.queue_free()
