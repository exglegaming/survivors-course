class_name UpgradeManager
extends Node


@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

var current_upgrades: Dictionary = {}


func _ready() -> void:
	experience_manager.level_up.connect(_on_level_up)


func _on_level_up(_current_level: int) -> void:
	var chosen_upgrade: AbilityUpgrade = upgrade_pool.pick_random()
	if chosen_upgrade == null: return

	var upggrade_screen_instance: UpgradeScreen = upgrade_screen_scene.instantiate()
	add_child(upggrade_screen_instance)
	upggrade_screen_instance.set_ability_upgrade([chosen_upgrade])


func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade: = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1,
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
