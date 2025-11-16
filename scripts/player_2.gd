extends CharacterBody2D
class_name PlayerController_2

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var jump_count = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count == 1:
		velocity.y = JUMP_VELOCITY
		jump_count = 2

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_count = 1

	if !Input.is_action_just_pressed("jump") and is_on_floor():
		jump_count = 0

#get input direction 1,0.-1
	var direction := Input.get_axis("move_left", "move_right")
	
	#flips sprite
	if direction>0:
		animated_sprite.flip_h = false
	elif direction<0:
		animated_sprite.flip_h = true
	
	#animation player
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	
	
	#movement applier
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()
