class_name UpgradeManager
extends Node


const UPGRADE_AXE: Ability = preload("uid://cj6rjscy87rmy")
const UPGRADE_AXE_DAMAGE: AbilityUpgrade = preload("uid://i4ywhxpm686q")
const UPGRADE_SWORD_RATE: AbilityUpgrade = preload("uid://1dphxq8g21ol")
const UPGRADE_SWORD_DAMAGE: AbilityUpgrade = preload("uid://cp23oy5y0sqnt")
const UPGRADE_PLAYER_SPEED: AbilityUpgrade = preload("uid://dnp1exxd7jgno")

@export var experience_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

var current_upgrades: Dictionary = {}
var upgrade_pool: WeightedTable = WeightedTable.new()


func _ready() -> void:
	upgrade_pool.add_item(UPGRADE_AXE, 10)
	upgrade_pool.add_item(UPGRADE_SWORD_RATE, 10)
	upgrade_pool.add_item(UPGRADE_SWORD_DAMAGE, 10)
	upgrade_pool.add_item(UPGRADE_PLAYER_SPEED, 5)

	experience_manager.level_up.connect(_on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade: = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1,
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1

	if upgrade.max_quantity > 0:
		var current_quantity: int = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)

	update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade) -> void:
	if chosen_upgrade.id == UPGRADE_AXE.id:
		upgrade_pool.add_item(UPGRADE_AXE_DAMAGE, 10)


func pick_upgrades() -> Array[AbilityUpgrade]:
	var chosen_upgrades: Array[AbilityUpgrade] = []
	for i: int in 2:
		if upgrade_pool.items.size() == chosen_upgrades.size(): break
		var chosen_upgrade: Resource = upgrade_pool.pick_item(chosen_upgrades) # Here
		chosen_upgrades.append(chosen_upgrade)

	return chosen_upgrades


func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)


func _on_level_up(_current_level: int) -> void:
	var upgrade_screen_instance: UpgradeScreen = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades: Array[AbilityUpgrade] = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrade(chosen_upgrades)
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)
