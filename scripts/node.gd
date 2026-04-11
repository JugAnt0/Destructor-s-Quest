extends Node

@onready var retry: TextureButton = $main/Retry
@onready var cont: TextureButton = $main/continue
@onready var settings: TextureButton = $main/settings
@onready var r: Label = $main/Retry/R
@onready var space: Label = $main/continue/Space
@onready var t: Label = $main/settings/T
@onready var main: Node = $main
@onready var settings_menu: Node = $settings_menu
@onready var volume_slider: HSlider = $settings_menu/Volume_slider

@onready var damage_label: Label = $settings_menu/Stats/damage_label
@onready var reload_speed_label: Label = $settings_menu/Stats/reload_speed_label
@onready var speed_label: Label = $settings_menu/Stats/speed_label
@onready var max_health_label: Label = $settings_menu/Stats/max_health_label
@onready var piercing_label: Label = $settings_menu/Stats/piercing_label
@onready var knockback_label: Label = $settings_menu/Stats/knockback_label

func _ready() -> void:
	
	settings_menu.visible = false
	damage_label.text = "Damage:  " +str(Stats.daño)
	reload_speed_label.text = "Reload Speed:  " +str(Stats.reload_speed)
	speed_label.text = "Movement Speed:  " +str(Stats.velocidad)
	max_health_label.text = "Max Health:  " +str(Stats.max_vida)
	piercing_label.text = "Piercing:  " +str(Stats.piercing)
	knockback_label.text = "Knockback:  " +str(Stats.player_knockback)
	
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err == OK:
		var volume = config.get_value("audio", "volume", 1.0)
		
		volume_slider.value = volume
		
		AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
			linear_to_db(max(volume, 0.001))
		)
	else:
		volume_slider.value = 1.0
		
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
		
	if Input.is_action_just_pressed("space"):
		get_tree().paused = false
		queue_free()
		
	if Input.is_action_just_pressed("T"):
		main.visible = false
		settings_menu.visible = true

	
func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	

func _on_continue_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_settings_pressed() -> void:
	main.visible = false
	settings_menu.visible = true


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(value)
	)
	var config = ConfigFile.new()
	config.set_value("audio", "volume", value)
	config.save("user://settings.cfg")

func _on_go_back_pressed() -> void:
	main.visible = true
	settings_menu.visible = false
