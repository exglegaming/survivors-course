class_name MetaMenu
extends CanvasLayer


const META_UPGRADE_CARD_SCENE: PackedScene = preload("uid://cdvcbmrkjcpce")
const MAIN_MENU_SCENE_UID: StringName = "uid://ky0b6i7ugvrp"

@export var upgrades: Array[MetaUpgrade] = []

@onready var grid_container: GridContainer = %GridContainer
@onready var back_button: SoundButton = %BackButton


func _ready() -> void:
	for child: Node in grid_container.get_children():
		child.queue_free()

	for upgrade: MetaUpgrade in upgrades:
		var meta_upgrade_card_instance: MetaUpgradeCard = META_UPGRADE_CARD_SCENE.instantiate()
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)
	
	back_button.pressed.connect(_on_back_pressed)


func _on_back_pressed() -> void:
	ScreenTransition.transition_to_scene(MAIN_MENU_SCENE_UID)
