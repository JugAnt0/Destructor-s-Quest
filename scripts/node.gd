extends Node

@onready var retry: TextureButton = $CanvasLayer/Retry
@onready var cont: TextureButton = $CanvasLayer/continue
@onready var settings: TextureButton = $CanvasLayer/settings
@onready var r: Label = $CanvasLayer/Retry/R
@onready var space: Label = $CanvasLayer/continue/Space
@onready var t: Label = $CanvasLayer/settings/T

func _ready() -> void:
	get_tree().paused = true
	
func _process(_delta: float) -> void:
	
	if settings.is_hovered() == true:
		t.show()
	else:
		t.hide()
		
	if cont.is_hovered() == true:
		space.show()
	else:
		space.hide()
		
	if retry.is_hovered() == true:
		r.show()
	else:
		r.hide()
		
	if Input.is_action_just_pressed("R"):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		
	if Input.is_action_just_pressed("R"):
		get_tree().paused = false
		queue_free()
		
	if Input.is_action_just_pressed("T"):
		pass


func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	

func _on_continue_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_settings_pressed() -> void:
	pass # Replace with function body.
