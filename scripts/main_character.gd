extends CharacterBody2D

@onready var MainCharacter: CharacterBody2D = $"."
@onready var ex: GPUParticles2D = $bullet_explosion
@onready var icon: Sprite2D = $Icon
@onready var fire_motors: AnimatedSprite2D = $FireMotors
var knockback_to_self = Vector2.ZERO
var invincible = false
var invincibility_time = 1.0
var velocidad = Stats.velocidad
var last_health := 5
var bullet_scene = preload("res://scenes/bullet.tscn")
var player : CharacterBody2D
var can_shoot = true

func take_damage(amount, from_position: Vector2):
	if invincible:
		return

	Stats.vida -= amount
	invincible = true

	# 💥 explosion + feedback
	ex.restart()
	icon.modulate = Color8(253, 0, 49, 255)

	# 💨 knockback (feels really good)
	var dir = (global_position - from_position).normalized()
	knockback_to_self += dir * 100

	start_invincibility()

func start_invincibility():
	for i in range(6):
		icon.modulate.a = 0.3
		await get_tree().create_timer(0.1).timeout
		icon.modulate.a = 1.0
		await get_tree().create_timer(0.1).timeout

	icon.modulate = Color8(255, 255, 255, 255)
	invincible = false
	

func shoot():
	if !can_shoot:
		return
		
	can_shoot = false
	
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)

	var dir = (get_global_mouse_position() - global_position).normalized()

	bullet.global_position = global_position + dir * 20
	bullet.direction = dir
	
	await get_tree().create_timer(Stats.reload_speed).timeout
	can_shoot = true
	
	
func _ready() -> void:
	MainCharacter.player = self
	last_health = Stats.vida
	
	
func _physics_process(delta):
	
	var direction = Input.get_vector("left", "right", "up", "down")
	knockback_to_self = knockback_to_self.move_toward(Vector2.ZERO, 150  * delta)
	velocity = direction * velocidad + knockback_to_self
	if velocity == Vector2(0, 0):
		fire_motors.hide()
	else:
		fire_motors.show()
	
	last_health = Stats.vida
	
	
	move_and_slide()
	
	if Input.is_action_pressed("left_click"):
		shoot()
		
		
	rotation += deg_to_rad(90)
	look_at(get_global_mouse_position())
	rotation += PI/2
	
	
	if Stats.vida <= 0:
		queue_free()

	
	
	if global_position.x > Limits.right_limit:
		global_position.x = Limits.left_limit
	elif global_position.x < Limits.left_limit:
		global_position.x = Limits.right_limit
	if global_position.y > Limits.down_limit:
		global_position.y = Limits.up_limit
	elif global_position.y < Limits.up_limit:
		global_position.y = Limits.down_limit
	
	
	
