extends CharacterBody2D
var pierce = Stats.piercing
var speed = 200
var direction = Vector2.ZERO

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()

	rotation = direction.angle()
	

	
	
	
	
