class_name SoundButton
extends Button


@onready var random_stream_player_component: RandomStreamPlayerComponent = $RandomStreamPlayerComponent


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	random_stream_player_component.play_random()
