extends Area2D

var player : CharacterBody2D
var speed := 60.0
var health = 2
var bullet_scene = preload("res://scenes/enemy_bullet.tscn")
@onready var enemy: Area2D = $"."
@onready var timer: Timer = $Timer

func shoot():
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)

	var dir = transform.x.rotated(-PI/2)


	bullet.global_position = global_position + dir * 20
	bullet.direction = dir
	
func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):

	if player == null:
		return

	var dir = (player.global_position - global_position).normalized()
	global_position += dir * speed * delta
	
	
	if global_position.distance_to(player.global_position) < 300:
		if timer.is_stopped():
			timer.start()
	
	
	rotation += deg_to_rad(90)
	look_at(player.global_position)
	rotation += PI/2

	if health <= 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Stats.vida -= 1
		
	if body.is_in_group("player_bullet"):
		health -= 1
		body.queue_free()
		
func _on_timer_timeout() -> void:
	shoot()
