class_name MainMenu
extends CanvasLayer


const MAIN_SCENE_UID: StringName = "uid://dua013ovd67cr"
const OPTIONS_SCENE: PackedScene = preload("uid://onry6cjjaqqa")


@onready var play_button: SoundButton = %PlayButton
@onready var options_button: SoundButton = %OptionsButton
@onready var quit_button: SoundButton = %QuitButton


func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_SCENE_UID)


func _on_options_pressed() -> void:
	var options_instance: OptionsMenu = OPTIONS_SCENE.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(_on_options_closed.bind(options_instance))


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_closed(options_instance: OptionsMenu) -> void:
	options_instance.queue_free()
