extends Control

@onready var back_button: Button = $backButton
@onready var pb_level_1: Button = $pb_level_1
@onready var pb_button: Button = $pb_level_2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_button.grab_focus()
	pb_level_1.text = stopwatch.pb_to_string()
	pb_button.text= stopwatch.pb_2_to_string()



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")




func _on_pb_reset_button_pressed() -> void:
	GameManager.reset_pb()
	


func _on_pb_2_reset_button_pressed() -> void:
	GameManager.reset_pb_2()
