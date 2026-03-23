extends Area2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var explosion_sound: AudioStreamPlayer2D = $explosion_sound
@onready var st: StaticBody2D = $StaticBody2D
@onready var icon: Sprite2D = $Icon
var knockback = Stats.knockback
var player : CharacterBody2D
var speed := 75.0
var health = 4
var bullet_scene = preload("res://scenes/purp_bullet.tscn")
@onready var enemy: Area2D = $"."
@onready var timer: Timer = $Timer
@onready var ex: GPUParticles2D = $bullet_explosion
var dead := false
var warning_scene = preload("res://scenes/warning_sign.tscn")
var warning

func shoot():
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	audio.play()
	var dir = transform.x.rotated(-PI/2)


	bullet.global_position = global_position + dir * 20
	bullet.direction = dir


func _exit_tree():
	if warning:
		warning.queue_free()
		
		
func _ready():
	player = get_tree().get_first_node_in_group("player")


	
	
func _physics_process(delta):
	if dead:
		return
		
	if player == null:
		return

	var dir = (player.global_position - global_position).normalized()
	global_position += (dir * speed + knockback) * delta
	knockback = knockback.move_toward(Vector2.ZERO, 300 * delta)
	
	
	if global_position.distance_to(player.global_position) < 300:
		if timer.is_stopped():
			timer.start()
	
	
	rotation += deg_to_rad(90)
	look_at(player.global_position)
	rotation += PI/2

	if health <= 0 and !dead:
		dead = true
		speed = 0
		timer.stop()
		icon.hide()
		$CollisionShape2D.disabled = true
		ex.restart()
		st.queue_free()
		await get_tree().create_timer(1.5).timeout
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	explosion_sound.play()
	if body.is_in_group("player"):
		body.take_damage(1, global_position)
		knockback = (global_position - body.global_position).normalized() * 50
	if body.is_in_group("player_bullet"):
		body.pierce -= 1
		knockback = (global_position - body.global_position).normalized() * Stats.player_knockback + Vector2(40, 40)
		if body.pierce < 0:
			body.queue_free()
		ex.restart()
		health -= Stats.daño
		icon.modulate =  Color8(253, 0, 49, 255)
		await get_tree().create_timer(0.1).timeout
		icon.modulate =  Color8(255, 255, 255, 255)
		
func _on_timer_timeout() -> void:
	shoot()
