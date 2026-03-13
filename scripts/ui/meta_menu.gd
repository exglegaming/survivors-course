class_name MetaMenu
extends CanvasLayer


const META_UPGRADE_CARD_SCENE: PackedScene = preload("uid://cdvcbmrkjcpce")

@export var upgrades: Array[MetaUpgrade] = []

@onready var grid_container: GridContainer = %GridContainer


func _ready() -> void:
	for upgrade: MetaUpgrade in upgrades:
		var meta_upgrade_card_instance: MetaUpgradeCard = META_UPGRADE_CARD_SCENE.instantiate()
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)
