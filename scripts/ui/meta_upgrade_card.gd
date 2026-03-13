class_name MetaUpgradeCard
extends PanelContainer


const LEFT_CLICK: StringName = "left_click"
const SELECTED: StringName = "selected"

var stored_upgrade: MetaUpgrade

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel


func _ready() -> void:
	purchase_button.pressed.connect(_on_purchase_pressed)


func set_meta_upgrade(upgrade: MetaUpgrade) -> void:
	stored_upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	_update_progress()


func _update_progress() -> void:
	var currency: float = MetaProgression.save_data["meta_upgrade_currency"]
	var percent: float = currency / stored_upgrade.experience_cost
	percent = min(percent, 1.0)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1.0
	progress_label.text = "%0d/%0d" % [currency, stored_upgrade.experience_cost]


func _on_purchase_pressed() -> void:
	if stored_upgrade == null: return
	MetaProgression.add_meta_upgrade(stored_upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= stored_upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "_update_progress")
	animation_player.play(SELECTED)
