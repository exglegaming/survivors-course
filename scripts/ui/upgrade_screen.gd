class_name UpgradeScreen
extends CanvasLayer


signal upgrade_selected(upgrade: AbilityUpgrade)

const OUT: StringName = "out"

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	get_tree().paused = true


func set_ability_upgrade(upgrades: Array[AbilityUpgrade]) -> void:
	var delay: float = 0.0
	for upgrade: AbilityUpgrade in upgrades:
		var card_instance: AbilityUpgradeCard = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.play_in(delay)
		card_instance.selected.connect(_on_upgrade_selected.bind(upgrade))
		delay += .2


func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	upgrade_selected.emit(upgrade)
	animation_player.play(OUT)
	await animation_player.animation_finished
	get_tree().paused = false
	queue_free()
