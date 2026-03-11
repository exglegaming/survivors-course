class_name Main
extends Node


const PAUSE: StringName = "pause"
const PAUSE_MENU_SCENE: PackedScene = preload("uid://bybw3sof4fr14")

@export var end_screen_scene: PackedScene

@onready var player: Player = %Player


func _ready() -> void:
	player.health_component.died.connect(_on_player_died)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(PAUSE):
		add_child(PAUSE_MENU_SCENE.instantiate())
		get_tree().root.set_input_as_handled()


func _on_player_died() -> void:
	var end_screen_instance: EndScreen = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
	MetaProgression.save()
