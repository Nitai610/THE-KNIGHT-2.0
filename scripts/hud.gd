extends Control

@onready var timerlabel: Label = $timerlabel




func _process(delta: float) -> void:
	$timerlabel.text = stopwatch.time_to_string()
