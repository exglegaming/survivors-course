extends CanvasLayer


signal transition_halfway

const DEFAULT: StringName = "default"

var skip_emit: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func transition() -> void:
	animation_player.play(DEFAULT)
	await transition_halfway
	skip_emit = true
	animation_player.play_backwards(DEFAULT)


func transition_to_scene(scene_path: StringName) -> void:
	transition()
	await transition_halfway
	get_tree().change_scene_to_file(scene_path)


func emit_transition_halfway() -> void:
	if skip_emit:
		skip_emit = false
		return
	transition_halfway.emit()
