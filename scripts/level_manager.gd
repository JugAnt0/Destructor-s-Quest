extends Node
var current_level : String = "res://scenes/game.tscn"
var next_level : String = ""

var pause_menu_scene = preload("res://scenes/menu.tscn")
var pause_menu_instance = null

func toggle_pause_menu():
	if is_instance_valid(pause_menu_instance):
		close_menu()
	else:
		open_menu()

func open_menu():
	pause_menu_instance = pause_menu_scene.instantiate()
	
	get_tree().current_scene.add_child(pause_menu_instance)
	get_tree().paused = true

func close_menu():
	pause_menu_instance.queue_free()
	pause_menu_instance = null
	get_tree().paused = false
	
func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		toggle_pause_menu()
			
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
