extends Node2D

@onready var scoreLabel = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	scoreLabel.text = str(Globals.high_score / 2000) + " м."


func _on_button_pressed():
	self.get_parent().start_level()
	self.queue_free()
