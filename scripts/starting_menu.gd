extends Node2D
@onready var starto: TextureButton = $TextureButton
@onready var space: Label = $space

func _ready() -> void:
	Hearts.hearts.hide()



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		Hearts.hearts.show()
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	if starto.is_hovered() == true:
		space.show()
	else:
		space.hide()
