extends Node2D

@onready var coin_check: Label = $Labels/coin_check
@onready var another_coin_check: Label = $Labels/another_coin_check
var level2_coins = GameManager.level_2_coins
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.score = 0
	GameManager.level_2_coins = 24
	GameManager.level_2_coins_left = GameManager.level_2_coins
	stopwatch.time_reset()
	stopwatch.time_stopped=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.score>=level2_coins:
		coin_check.text = "YOU HAVE COLLECTED " + str(GameManager.score) + " COINS WHICH IS ALL OF THE COINS IN THE LEVEL! GOOD JOB I KNOW IT WAS HARD(like you)"
	else:
		coin_check.text = "YOU HAVE COLLECTED " + str(GameManager.score) + " COINS WHICH IS NOT ALL OF THE COINS IN THE LEVEL NOOB YOU STILL HAVE "+ str(GameManager.level_2_coins_left) + " COINS TO COLLECT RESTART NOW OR BE NOOB FOREVER"
		another_coin_check.text = "NOOB YOU STILL HAVE "+str(GameManager.level_2_coins_left)+" COINS TO COLLECT"
