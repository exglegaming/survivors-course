extends Node


const SAVE_FILE_PATH: StringName = "user://game.save"

var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta_upgrades": {}
}


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_collected)
	_load_save_file()


func add_meta_upgrade(upgrade: MetaUpgrade) -> void:
	if !save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0,
		}

	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	save()


func save() -> void:
	var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)


func _load_save_file() -> void:
	if !FileAccess.file_exists(SAVE_FILE_PATH): return

	var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()


func _on_experience_collected(number: float) -> void:
	save_data["meta_upgrade_currency"] += number
