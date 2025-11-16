extends Control

@onready var level_1_button: Button = $VBoxContainer/level1Button
@onready var death_counter: Label = $VBoxContainer/deathCounter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_1_button.grab_focus()
	Global.load_deaths()

func _process(delta: float) -> void:
	death_counter.text = "DEATH COUNT: " + str(Global.death_count) 

func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
