extends Control
@onready var pause_menu: Control = $"."
@onready var resume_button: Button = $VBoxContainer/resumeButton
@onready var pb_button: Button = $pbButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.visible = false
	if get_tree().current_scene.scene_file_path == "res://scenes/levels/level_2.tscn":
		pb_button.text= stopwatch.pb_2_to_string()
	else:
		pb_button.text= stopwatch.pb_to_string()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
		pause_menu.visible = get_tree().paused
		resume_button.grab_focus()




func _on_menu_button_pressed() -> void:
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_quit_button_pressed() -> void:
	
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused
	get_tree().quit()

func _on_resume_button_pressed() -> void:
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused


func _on_restart_button_pressed() -> void:
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused
	get_tree().reload_current_scene()
