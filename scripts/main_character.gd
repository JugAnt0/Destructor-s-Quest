extends CharacterBody2D

@onready var MainCharacter: CharacterBody2D = $"."

var velocidad = 100.0

var bullet_scene = preload("res://scenes/bullet.tscn")

var player : CharacterBody2D

var shoot_cooldown = 1.2
var can_shoot = true


func shoot():
	if !can_shoot:
		return
		
	can_shoot = false
	
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)

	var dir = (get_global_mouse_position() - global_position).normalized()

	bullet.global_position = global_position + dir * 20
	bullet.direction = dir
	
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
	
	
func _ready() -> void:
	MainCharacter.player = self
	print("Player created")
	
	
func _physics_process(_delta):

	var direction = Input.get_vector("left", "right", "up", "down")

	velocity = direction * velocidad

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
	
	
	
