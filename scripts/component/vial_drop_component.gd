class_name VialDropComponent
extends Node


@export_range(0, 1) var drop_percent: float = .5
@export var health_component: HealthComponent
@export var vial_scene: PackedScene


func _ready() -> void:
	health_component.died.connect(_on_died)


func _on_died() -> void:
	if randf() > drop_percent: return
	if vial_scene == null: return
	if !owner is Node2D: return

	var spawn_position: Vector2 = (owner as Node2D).global_position
	var vial_instance: ExperienceVial = vial_scene.instantiate()
	owner.get_parent().add_child(vial_instance)
	vial_instance.global_position = spawn_position
