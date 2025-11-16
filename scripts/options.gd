extends Control

var waiting_for_input = false
var music_on = true
var phonk_on = false
@onready var jump_button: Button = $VBoxContainer/jumpButton
@onready var label_2: Label = $VBoxContainer/Label2
@onready var music_button: Button = $VBoxContainer/musicButton
@onready var back_button: Button = $VBoxContainer/backButton
@onready var music_phonk: Button = $VBoxContainer/musicPhonk


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_button.grab_focus()
	load_jump_key()  # Load saved jump key when scene starts
	load_music_state()


func _on_jump_button_pressed() -> void:
	label_2.text = "Press a key for Jump..."
	waiting_for_input = true


func _input(event: InputEvent) -> void:
	if waiting_for_input and event is InputEventKey and event.pressed:
		var keycode = event.keycode
		var keyname = OS.get_keycode_string(keycode)
		back_button.grab_focus()
		label_2.text = "JUMP KEY SET TO: " + keyname.to_upper()
		Global.jump_key = keyname
		jump_button.text = keyname

		# Clear old bindings
		InputMap.action_erase_events("jump_button_remap")

		# Add new one
		var new_event := InputEventKey.new()
		new_event.keycode = keycode
		InputMap.action_add_event("jump_button_remap", new_event)

		# Save to config file
		save_jump_key(keyname)

		waiting_for_input = false


# === Save/Load System ===
func save_jump_key(keyname: String) -> void:
	var config := ConfigFile.new()
	config.set_value("controls", "jump_button_remap", keyname)
	config.save("user://settings.cfg")
	print("Saved jump key:", keyname)


func save_music_state(is_muted: bool) -> void:
	var config := ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		print("No previous settings, creating new config")
	config.set_value("controls", "music_muted", is_muted)
	config.save("user://settings.cfg")
	print("Saved music state:", is_muted)

func save_phonk_state(is_phonk_on: bool) -> void:
	var config := ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		print("No previous settings, creating new config")

	config.set_value("controls", "phonk_on", is_phonk_on)
	config.save("user://settings.cfg")
	print("Saved phonk state:", is_phonk_on)


func load_jump_key() -> void:
	var config := ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		var saved_key: String = config.get_value("controls", "jump_button_remap", "")
		if saved_key != "":
			var key_event := InputEventKey.new()
			key_event.keycode = OS.find_keycode_from_string(saved_key)
			InputMap.action_erase_events("jump_button_remap")
			InputMap.action_add_event("jump_button_remap", key_event)
			jump_button.text = saved_key.to_upper()
			label_2.text = "LOADED JUMP KEY: " + saved_key.to_upper()


func load_music_state() -> void:
	var config := ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		return  # No saved settings

	var is_muted: bool = config.get_value("controls", "music_muted", false)
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_bus, is_muted)
	music_on = not is_muted
	music_button.text = "MUSIC: ON" if music_on else "MUSIC: OFF"


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_music_button_pressed() -> void:
	var music_bus = AudioServer.get_bus_index("Music")

	if music_on:
		# Turn music off
		AudioServer.set_bus_mute(music_bus, true)
		music_button.text = "MUSIC: OFF"
		music_on = false
	else:
		# Turn music on and make sure phonk is off
		AudioServer.set_bus_mute(music_bus, false)
		music_button.text = "MUSIC: ON"
		music_on = true

		var phonk_bus = AudioServer.get_bus_index("Phonk")
		AudioServer.set_bus_mute(phonk_bus, true)
		music_phonk.text = "PHONK: OFF"
		phonk_on = false
		back_button.grab_focus()


func _on_music_phonk_pressed() -> void:
	var phonk_bus = AudioServer.get_bus_index("Phonk")

	if phonk_on:
		# Turn phonk off
		AudioServer.set_bus_mute(phonk_bus, true)
		music_phonk.text = "PHONK: OFF"
		phonk_on = false
	else:
		# Turn phonk on and make sure main music is off
		AudioServer.set_bus_mute(phonk_bus, false)
		music_phonk.text = "PHONK: ON"
		phonk_on = true
		Global.phonk=true

		var music_bus = AudioServer.get_bus_index("Music")
		AudioServer.set_bus_mute(music_bus, true)
		music_button.text = "MUSIC: OFF"
		music_on = false
		back_button.grab_focus()
