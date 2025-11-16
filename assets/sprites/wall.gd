extends Node2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var game_manager: Node = %GameManager

	game_manager.score

func _on_game_manager_finish() -> void:
	pass # Replace with function body.
