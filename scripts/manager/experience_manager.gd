class_name ExperienceManager
extends Node


var current_experience: float = 0


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_vial_collected)


func increment_experience(number: float) -> void:
	current_experience += number
	print(current_experience)


func _on_experience_vial_collected(number: float) -> void:
	increment_experience(number)
