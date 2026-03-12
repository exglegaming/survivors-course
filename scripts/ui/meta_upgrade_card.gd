class_name MetaUpgradeCard
extends PanelContainer


const LEFT_CLICK: StringName = "left_click"
const SELECTED: StringName = "selected"

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	gui_input.connect(_on_gui_input)


func set_meta_upgrade(upgrade: MetaUpgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func _select_card() -> void:
	animation_player.play(SELECTED)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed(LEFT_CLICK):
		_select_card()
