class_name AbilityUpgradeCard
extends PanelContainer


signal selected

const LEFT_CLICK: StringName = "left_click"
const IN: StringName = "in"
const HOVER: StringName = "hover"
const SELECTED: StringName = "selected"
const DISCARD: StringName = "discard"

var disabled: bool = false

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hover_animation_player: AnimationPlayer = $HoverAnimationPlayer


func _ready() -> void:
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(_on_mouse_entered)


func play_in(delay: float = 0.0) -> void:
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	animation_player.play(IN)


func set_ability_upgrade(upgrade: AbilityUpgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func _play_discard() -> void:
	animation_player.play(DISCARD)


func _select_card() -> void:
	disabled = true
	animation_player.play(SELECTED)

	for other_card: AbilityUpgradeCard in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card._play_discard()

	await animation_player.animation_finished
	selected.emit()


func _on_gui_input(event: InputEvent) -> void:
	if disabled: return

	if event.is_action_pressed(LEFT_CLICK):
		_select_card()


func _on_mouse_entered() -> void:
	if disabled: return
	hover_animation_player.play(HOVER)
