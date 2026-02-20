class_name UpgradeScreen extends CanvasLayer


@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer


func _ready() -> void:
	get_tree().paused = true


func set_ability_upgrade(upgrades: Array[AbilityUpgrade]) -> void:
	for upgrade: AbilityUpgrade in upgrades:
		var card_instance: AbilityUpgradeCard = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
