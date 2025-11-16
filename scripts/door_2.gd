extends StaticBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var closed: Sprite2D = $closed
@onready var opened: Sprite2D = $opened

var open_2 = false

func _ready() -> void:
	opened.hide()

func _process(delta: float) -> void:
	if not open_2 and GameManager.level_2_coins_left <= 0:
		open_door()
func open_door():
	closed.hide()
	collision_shape.disabled = true
	opened.show()
	open_2 = true
