extends Node2D

const speed = 60

var direction = -1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.flip_h=true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h=true
		
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h=false
	position.x += direction * speed * delta


#	if score>=coins:
#		score_label.text = "You collected ALL OF THE COINS! GOOD BOY. "
#	else:
#		score_label.text = "You collected "+str(score)+" coins! YOU STILL HAVE " + str(left) + " COINS LEFT. NOW GO BACK AND COLLECT THEM ALL >[ "
