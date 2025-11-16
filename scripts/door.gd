extends StaticBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var closed: Sprite2D = $closed
@onready var opened: Sprite2D = $opened

var open = false

func _ready() -> void:
	opened.hide()

func _process(delta: float) -> void:
	if not open and GameManager.left <= 0:
		open_door()
func open_door():
	closed.hide()
	collision_shape.disabled = true
	opened.show()
	open = true
