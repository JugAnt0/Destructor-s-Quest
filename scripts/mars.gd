extends Area2D
@onready var ex: GPUParticles2D = $mars_explosion
@onready var explosion_sound: AudioStreamPlayer2D = $explosion_sound
@onready var collision: CollisionShape2D = $CollisionShape2D
var invincible = false
var phase_2_triggered = false
@onready var icon: Sprite2D = $Icon
@onready var progress_bar: ProgressBar = $ProgressBar
signal died
@onready var progress_bar2: ProgressBar = $ProgressBar2

var player : CharacterBody2D

var health = 200
@onready var enemy: Area2D = $"."
var dead := false


			
func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if dead:
		return
		
	if player == null:
		return


	progress_bar.value = health
	progress_bar2.value = health

	
	

	icon.rotation -= PI/7500

	if health <= 0 and !dead:
		dead = true
		
		icon.hide()
		$CollisionShape2D.disabled = true
	
		await get_tree().create_timer(1.5).timeout
		queue_free()
		emit_signal("died")
		
func _on_body_entered(body: Node2D) -> void:
	if invincible:
		return
	
	explosion_sound.play()
	if body.is_in_group("player"):
		body.take_damage(1, global_position)
	if body.is_in_group("player_bullet"):
		ex.restart()
		body.queue_free()
		
		
		

		health -= Stats.daño
		icon.modulate =  Color8(253, 0, 49, 255)
		await get_tree().create_timer(0.1).timeout
		icon.modulate =  Color8(255, 255, 255, 255)
