extends CanvasLayer


@export var arena_time_manager: ArenaTimeManager

@onready var label: Label = %Label


func _process(_delta: float) -> void:
	if arena_time_manager == null: return
	var time_elapsed: float = arena_time_manager.get_time_elapsed()
	label.text = format_seconds_to_string(time_elapsed)


func format_seconds_to_string(seconds: float) -> String:
	var minutes: float = floorf(seconds / 60)
	var remaining_seconds: float = seconds - (minutes * 60)
	return ("%d:%02d" % [minutes, floorf(remaining_seconds)])
