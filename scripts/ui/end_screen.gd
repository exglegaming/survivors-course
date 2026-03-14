class_name EndScreen
extends CanvasLayer


const MAIN_SCENE_UID: StringName = "uid://dua013ovd67cr"
const MAIN_MENU_UID: StringName = "uid://ky0b6i7ugvrp"
const META_MENU_SCENE_UID: StringName = "uid://dmisgjdtlbysu"

@onready var continue_button: Button = %ContinueButton
@onready var quit_button: Button = %QuitButton
@onready var title_label: Label = %TitleLabel
@onready var description_label: Label = %DescriptionLabel
@onready var panel_container: PanelContainer = %PanelContainer
@onready var victory_stream_player: AudioStreamPlayer = $VictoryStreamPlayer
@onready var defeat_stream_player: AudioStreamPlayer = $DefeatStreamPlayer


func _ready() -> void:
	panel_container.pivot_offset = panel_container.size / 2
	var tween: Tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


	get_tree().paused = true
	continue_button.pressed.connect(_on_continue_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func set_defeat() -> void:
	title_label.text = "Defeat"
	description_label.text = "You lost!"
	play_jingle(true)


func play_jingle(defeat: bool = false) -> void:
	if defeat:
		defeat_stream_player.play()
	else:
		victory_stream_player.play()


func _on_continue_button_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file(META_MENU_SCENE_UID)


func _on_quit_button_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU_UID)
