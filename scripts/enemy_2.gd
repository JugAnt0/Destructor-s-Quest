extends Area2D

@onready var icon: Sprite2D = $Icon

var knockback = Stats.knockback
var player : CharacterBody2D
var speed := 120.0
var health = 1
@onready var enemy: Area2D = $"."
@onready var ex: GPUParticles2D = $bullet_explosion
var dead := false


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
	
	
	rotation += deg_to_rad(90)
	look_at(player.global_position)
	rotation += PI/2

	if health <= 0 and !dead:
		dead = true
		speed = 0
		icon.hide()
		$CollisionShape2D.disabled = true
		ex.restart()
		await get_tree().create_timer(1.5).timeout
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Stats.vida -= 1
		knockback = (global_position - body.global_position).normalized() * 250
	if body.is_in_group("player_bullet"):
		body.pierce -= 1
		knockback = (global_position - body.global_position).normalized() * Stats.player_knockback
		
		if body.pierce < 0:
			body.queue_free()
		ex.restart()
		health -= Stats.daño
		icon.modulate =  Color8(253, 0, 49, 255)
		await get_tree().create_timer(0.1).timeout
		icon.modulate =  Color8(255, 255, 255, 255)
