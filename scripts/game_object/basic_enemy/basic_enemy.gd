class_name Enemy
extends CharacterBody2D


const MAX_SPEED: float = 40.0

@onready var health_component: HealthComponent = $HealthComponent

@onready var visuals: Node2D = $Visuals


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()

	var move_sign: float = signf(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)


func get_direction_to_player() -> Vector2:
	var player_node: Player = get_tree().get_first_node_in_group("player")
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
