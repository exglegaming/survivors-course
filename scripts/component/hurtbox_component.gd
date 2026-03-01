class_name HurtboxComponent
extends Area2D


@export var health_component: HealthComponent

var floating_text_scene: PackedScene = preload("uid://cvverctnr4k3x")


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if !area is HitboxComponent: return
	if health_component == null: return

	var hitbox_component: HitboxComponent = area
	health_component.damage(hitbox_component.damage)

	var floating_text: FloatingText = floating_text_scene.instantiate()
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)

	floating_text.global_position = global_position + (Vector2.UP * 16)
	floating_text.start(str(int(hitbox_component.damage)))
