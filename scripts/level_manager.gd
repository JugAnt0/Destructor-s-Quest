extends Node
var current_level : String = "res://scenes/game.tscn"
var next_level : String = ""

func load_level(path : String):
	current_level = path
	get_tree().change_scene_to_file(path)


func set_next_level(path : String):
	next_level = path

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("R"):
		Stats.max_vida = 5
		Stats.vida = 5
		Stats.daño = 1
		Stats.velocidad = 100.0
		Stats.reload_speed = 1
		Stats.propulsion_distance = 20
		Stats.propulsion_reload_time = 2
		Stats.piercing = 0
		Stats.bullets_per_shot = 1
		Stats.alcance = 100
		Stats.knockback = Vector2.ZERO
		Stats.player_knockback = 75
		Hearts.hearts.show()
		get_tree().change_scene_to_file("res://scenes/game.tscn")
func go_to_next_level():
	if next_level != "":
		load_level(next_level)
		
func load_upgrade():
	get_tree().change_scene_to_file("res://scenes/upgrades.tscn")
