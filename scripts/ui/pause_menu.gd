class_name PauseMenu
extends CanvasLayer


const DEFAULT: StringName = "default"
const PAUSE: StringName = "pause"
const MAIN_MENU: StringName = "uid://ky0b6i7ugvrp"
const OPTIONS_MENU_SCENE: PackedScene = preload("uid://onry6cjjaqqa")

var is_closing: bool

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = %PanelContainer
@onready var resume_button: SoundButton = %ResumeButton
@onready var options_button: SoundButton = %OptionsButton
@onready var quit_button: SoundButton = %QuitButton


func _ready() -> void:
	get_tree().paused = true
	panel_container.pivot_offset = panel_container.size / 2

	animation_player.play(DEFAULT)

	var tween: Tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

	resume_button.pressed.connect(_on_resume_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(PAUSE):
		_close()
		get_tree().root.set_input_as_handled()


func _close() -> void:
	if is_closing: return

	is_closing = true
	animation_player.play_backwards(DEFAULT)

	var tween: Tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, .3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)

	await tween.finished

	get_tree().paused = false
	queue_free()


func _on_resume_pressed() -> void:
	_close()


func _on_options_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	var options_menu_instance: OptionsMenu = OPTIONS_MENU_SCENE.instantiate()
	add_child(options_menu_instance)
	options_menu_instance.back_pressed.connect(_on_options_back_pressed.bind(options_menu_instance))


func _on_quit_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU)


func _on_options_back_pressed(options_menu: OptionsMenu) -> void:
	options_menu.queue_free()
