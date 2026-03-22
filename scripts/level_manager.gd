extends Node
var current_level : String = "res://scenes/game.tscn"
var next_level : String = ""

func load_level(path : String):
	current_level = path
	get_tree().change_scene_to_file(path)


func set_next_level(path : String):
	next_level = path


func go_to_next_level():
	if next_level != "":
		load_level(next_level)
		
func load_upgrade():
	get_tree().change_scene_to_file("res://scenes/upgrades.tscn")
