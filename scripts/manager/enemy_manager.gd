extends Node


const SPAWN_RADIUS: float = 375.0

@export var basic_enemy_scene: PackedScene

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var player: Player = get_tree().get_first_node_in_group("player")
	if player == null: return

	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0.0, TAU))
	var spawn_position: Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)

	var enemy: Enemy = basic_enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
