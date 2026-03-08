class_name WizardEnemy
extends CharacterBody2D


@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var visuals: Node2D = $Visuals
@onready var hit_random_audio_player_component: RandomStreamPlayer2DComponent = $HitRandomAudioPlayerComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

var is_moving: bool = false


func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)


func _process(_delta: float) -> void:
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()
	
	velocity_component.move(self)

	var move_sign: float = signf(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)


func set_is_moving(moving: bool) -> void:
	is_moving = moving


func _on_hit() -> void:
	hit_random_audio_player_component.play_random()
