extends Node2D
@onready var space: Label = $space
@onready var retry: TextureButton = $retry
@onready var esc: Label = $esc
@onready var exit: TextureButton = $exit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Stats.alcance =Stats.d_alcance
	Stats.bullets_per_shot =Stats.d_bullets_per_shot
	Stats.daño =Stats.d_daño
	Stats.knockback =Stats.d_knockback
	Stats.max_vida =Stats.d_max_vida
	Stats.velocidad =Stats.d_velocidad
	Stats.vida =Stats.d_vida
	Stats.piercing =Stats.d_piercing
	Stats.reload_speed =Stats.d_reload_speed
	Stats.propulsion_distance =Stats.d_propulsion_distance
	Stats.propulsion_reload_time =Stats.d_propulsion_reload_time
	BackgroundMusic.play_normal()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		Hearts.hearts.show()
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	if retry.is_hovered() == true:
		space.show()
	else:
		space.hide()
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	if exit.is_hovered() == true:
		esc.show()
	else:
		esc.hide()
func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
