extends Control

@onready var container = $CenterContainer/HBoxContainer
var upgrades = [
	preload("res://scenes/max_life_upgrade.tscn"),
	preload("res://scenes/strength_upgrade.tscn"),
	preload("res://scenes/upgrade_container.tscn"),
	preload("res://scenes/cura.tscn")
]

func _ready():
	randomize()
	Hearts.hearts.hide()
	var pool = upgrades.duplicate()
	pool.shuffle()

	for i in range(3):
		var upgrade = pool[i].instantiate()
		container.add_child(upgrade)
