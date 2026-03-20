extends Node

var d_max_vida = 5
var d_vida = 5
var d_daño = 1
var d_velocidad = 100.0
var d_reload_speed = 1
var d_propulsion_distance = 20
var d_propulsion_reload_time = 2
var d_piercing = 0
var d_bullets_per_shot = 1
var d_alcance = 100
var d_knockback := Vector2.ZERO
var d_player_knockback = 75


var max_vida = 5
var vida = 5
var daño = 1
var velocidad = 100.0
var reload_speed = 1
var propulsion_distance = 20
var propulsion_reload_time = 2
var piercing = 0
var bullets_per_shot = 1
var alcance = 100
var knockback := Vector2.ZERO
var player_knockback = 75

func _process(_delta: float) -> void:
	if vida <=0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
