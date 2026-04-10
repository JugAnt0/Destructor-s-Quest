extends Control

@onready var container = $CenterContainer/HBoxContainer

var upgrades = [
	preload("res://scenes/max_life_upgrade.tscn"),
	preload("res://scenes/strength_upgrade.tscn"),
	preload("res://scenes/upgrade_container.tscn"),
	preload("res://scenes/cura.tscn"),
	preload("res://scenes/speed_upgrade.tscn"),
	preload("res://scenes/pierce_upgrade.tscn"),
	preload("res://scenes/knockback_upgrade.tscn")
]

func _ready():
	randomize()
	Hearts.hearts.hide()

	# borrar upgrades anteriores si existen
	for child in container.get_children():
		child.queue_free()

	var pool = upgrades.duplicate()
	pool.shuffle()

	# asegurar máximo 3 pero sin pasarse del tamaño
	var count = min(3, pool.size())

	for i in range(count):
		var upgrade_scene = pool[i]
		var upgrade = upgrade_scene.instantiate()
		container.add_child(upgrade)
