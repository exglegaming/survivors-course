class_name HurtboxComponent
extends Area2D


@export var health_component: HealthComponent


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if !area is HitboxComponent: return
	if health_component == null: return

	var hitbox_component: HitboxComponent = area
	health_component.damage(hitbox_component.damage)
