class_name SwordAbilityController
extends Node


const MAX_RANGE: float = 150.0

@export_category("References")
@export var sword_ability: PackedScene

var damage: float = 5.0

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var player: Player = get_tree().get_first_node_in_group("player")
	if player == null: return

	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D): 
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)

	if enemies.size() == 0: return

	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance: float = a.global_position.distance_squared_to(player.global_position)
		var b_distance: float = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)

	var sword_instance: SwordAbility = sword_ability.instantiate()
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0.0, TAU)) * 4.0

	var enemy_direction: Vector2 = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
