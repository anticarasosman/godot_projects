extends Node

var Score = 0
@onready var player_score = %Player_score

func _ready():
	player_score.visible = true
	player_score.text = "0"

func add_point(points):
	Score += points
	player_score.text = str(Score)
