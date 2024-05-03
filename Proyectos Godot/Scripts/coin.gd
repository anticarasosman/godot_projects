extends Area2D
const VALUE = 20

@onready var game_manager = %Game_Manager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	game_manager.add_point(VALUE)
	animation_player.play("PickUp_animation")
