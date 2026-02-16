class_name BasicEnemy
extends CharacterBody2D


const MAX_SPEED: float = 75.0

@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	var player_node: Player = get_tree().get_first_node_in_group("player")
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO


func _on_area_entered(_area: Area2D) -> void:
	queue_free()
