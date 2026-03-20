extends CharacterBody2D


var speed = 200
var direction = Vector2.ZERO

func _physics_process(delta):
	rotation = direction.angle()
	 
	var collision = move_and_collide(direction * speed * delta)

	if collision:
		var body = collision.get_collider()

		if body.is_in_group("player"):
			Stats.vida -= 1
		queue_free()
