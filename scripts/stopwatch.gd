extends Node


var time_stopped= false
var total_time = 0.0
@export var actual_string: String

func time_reset():
	total_time = 0.0


func _process(delta: float) -> void:
	if time_stopped:
		return
	total_time+=delta


func time_to_string() -> String:
	var msec = fmod(total_time, 1)*100
	var sec = fmod(total_time, 60)
	var min = total_time/60
	var format_string = "%02d:%02d:%02d"
	actual_string = format_string % [min, sec, msec]
	return actual_string

func pb_2_to_string() -> String:
	var str2="00:00:00"
	if GameManager.pb_2 < 100000.0:
		var msec = int(fmod(GameManager.pb_2, 1) * 100)   # convert to int
		var sec = int(fmod(GameManager.pb_2, 60))         # convert to int
		var min = int(GameManager.pb_2 / 60)              # convert to int
		var format_string = "%02d:%02d:%02d"
		return format_string % [min, sec, msec]
	else:
		return str2

func pb_to_string() -> String:
	var str1="00:00:00"
	if GameManager.pb < 100000.0:
		var msec = int(fmod(GameManager.pb, 1) * 100)   # convert to int
		var sec = int(fmod(GameManager.pb, 60))         # convert to int
		var min = int(GameManager.pb / 60)              # convert to int
		var format_string = "%02d:%02d:%02d"
		return format_string % [min, sec, msec]
	else:
		return str1 
