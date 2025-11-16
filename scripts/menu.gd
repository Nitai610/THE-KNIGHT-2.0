extends Control
var phonk_on = true
var phonk_bus = AudioServer.get_bus_index("Phonk")
@onready var start_button: Button = $VBoxContainer/startButton
@onready var pb_button: Button = $VBoxContainer/pbButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.grab_focus()
	if Global.phonk == true:
		phonk_on = false
	if phonk_on:
		# Turn phonk off
		AudioServer.set_bus_mute(phonk_bus, true)
		phonk_on = false
		

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")



func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_pb_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pb_times.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options.tscn")
