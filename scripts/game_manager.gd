extends Node

var save_path = "user://times.save"
var save_path_2 = "user://times_2.save"
var level_path = "res://scenes/levels/"
var current_level = 1
# game stats
var level_1_coins = 19
var level_2_coins = 24
var score = 0
var left = level_1_coins
var level_2_coins_left = level_2_coins

# stopwatch times
var end_time = 0.0
var pb = 100000.0
var pb_2 = 100000.0


func _ready() -> void:
	load_data()
	load_data_2()


func add_point():
	score += 1
	left -= 1
	level_2_coins_left -=1


func next_scene():
	end_time = stopwatch.time_to_string()
	stopwatch.time_stopped = true
	score=0
	save()
	load_data()
	get_tree().reload_current_scene()
	
func next_scene_level2():
	end_time = stopwatch.time_to_string()
	stopwatch.time_stopped = true
	score=0
	left = level_1_coins
	level_2_coins_left = level_2_coins
	save_2()
	load_data_2()
	get_tree().reload_current_scene()


func save_2():
	print("HELLOW")
	var new_time_2 = float(stopwatch.total_time)

	# Ensure pb_2 is valid before comparing
	if pb_2 == null:
		pb_2 = 100000.0

	if new_time_2 < pb_2:
		pb_2 = new_time_2
		print("🎉 New personal best: " + str(pb_2))
	else:
		print("No new record. Current PB: " + str(pb_2))

	var file = FileAccess.open(save_path_2, FileAccess.WRITE)
	file.store_var(pb_2)
	file.close()


func save():
	var new_time = float(stopwatch.total_time)

	# Ensure pb is valid before comparing
	if pb == null:
		pb = 100000.0

	if new_time < pb:
		pb = new_time
		print("🎉 New personal best: " + str(pb))
	else:
		print("No new record. Current PB: " + str(pb))

	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(pb)
	file.close()


func load_data_2():
	if FileAccess.file_exists(save_path_2):
		var file = FileAccess.open(save_path_2, FileAccess.READ)
		var loaded = file.get_var()
		file.close()

		# Validate loaded data
		if loaded != null and typeof(loaded) in [TYPE_FLOAT, TYPE_INT]:
			pb_2 = float(loaded)
			print("Loaded PB:", pb_2)
		else:
			print("Saved PB invalid, resetting.")
			pb_2 = 100000.0
	else:
		print("No previous record found.")
		pb_2 = 100000.0

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var loaded = file.get_var()
		file.close()

		# Validate loaded data
		if loaded != null and typeof(loaded) in [TYPE_FLOAT, TYPE_INT]:
			pb = float(loaded)
			print("Loaded PB:", pb)
		else:
			print("Saved PB invalid, resetting.")
			pb = 100000.0
	else:
		print("No previous record found.")
		pb = 100000.0

func reset_pb():
	pb = 100000.0  # reset in memory
	var dir = DirAccess.open("user://")
	if dir.file_exists("times.save"):
		dir.remove("times.save")  # remove the saved file
	print("Personal best has been reset.")

func reset_pb_2():
	pb_2 = 100000.0  # reset in memory
	var dir = DirAccess.open("user://")
	if dir.file_exists("times_2.save"):
		dir.remove("times_2.save")  # remove the saved file
	print("Personal best 2 has been reset.")
