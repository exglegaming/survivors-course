class_name Enemy
extends CharacterBody2D


const MAX_SPEED: float = 40.0

@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var hit_random_audio_player_component: RandomStreamPlayer2DComponent = $HitRandomAudioPlayerComponent


func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)


func _physics_process(_delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	var move_sign: float = signf(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func _on_hit() -> void:
	hit_random_audio_player_component.play_random()
