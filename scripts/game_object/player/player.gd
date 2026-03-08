class_name Player
extends CharacterBody2D


var number_colliding_bodies: int = 0
var base_speed: float = 0.0

@onready var collision_area_2d: Area2D = $CollisionArea2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var health_bar: ProgressBar = $HealthBar
@onready var abilities: Node = $Abilities
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent


func _ready() -> void:
	base_speed = velocity_component.max_speed

	collision_area_2d.body_entered.connect(_on_body_entered)
	collision_area_2d.body_exited.connect(_on_body_exited)
	damage_interval_timer.timeout.connect(_on_damage_interval_timer_timeout)
	health_component.health_changed.connect(_on_health_changed)
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)
	update_health_display()


func _physics_process(_delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	var direction: Vector2 = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)

	if movement_vector.x || movement_vector.y != 0:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")

	var move_sign: float = signf(movement_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func get_movement_vector() -> Vector2:
	var x_movement: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement: float = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement) 


func check_deal_damage() -> void:
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped(): return
	health_component.damage(1.0)
	damage_interval_timer.start()


func update_health_display() -> void:
	health_bar.value = health_component.get_health_percent()


func _on_body_entered(_body: Node2D) -> void:
	number_colliding_bodies += 1
	check_deal_damage()


func _on_body_exited(_body: Node2D) -> void:
	number_colliding_bodies -= 1


func _on_damage_interval_timer_timeout() -> void:
	check_deal_damage()


func _on_health_changed() -> void:
	GameEvents.emit_player_damaged()
	update_health_display()


func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade is Ability:
		var ability: Ability = upgrade
		abilities.add_child(ability.ability_controller_scene.instantiate())
	elif upgrade.id == "player_speed":
		velocity_component.max_speed = base_speed + (base_speed * current_upgrades["player_speed"]["quantity"] * .1)
