extends Node2D

@onready var score_label: Label = $Labels/ScoreLabel
@onready var label_2: Label = $Labels/Label2
@onready var label: Label = $Labels/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.score = 0
	GameManager.level_1_coins = 19
	GameManager.left = GameManager.level_1_coins
	stopwatch.time_reset()
	stopwatch.time_stopped=false
	label.text = "Press "+str(Global.jump_key)+" to jump"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.score>=GameManager.level_1_coins:
		score_label.text = "You collected ALL OF THE COINS! GOOD BOY. "
		label_2.text = "You did it!"
	else:
		score_label.text = "You collected "+str(GameManager.score)+" coins!\n YOU STILL HAVE " + str(GameManager.left) + " COINS LEFT. NOW GO BACK AND COLLECT THEM ALL >[ "
		label_2.text = "You did NOT DO IT."
