# Global.gd
extends Node

var jump_key = "space"
var phonk = false
var death_count: int = 0  # Tracks total deaths
const SAVE_PATH := "user://save_game.cfg"  # Path to save/load deaths

# Load death count from file
func load_deaths():
	var config := ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		death_count = config.get_value("stats", "death_count", 0)

# Save death count to file
func save_deaths():
	var config := ConfigFile.new()
	config.set_value("stats", "death_count", death_count)
	config.save(SAVE_PATH)
