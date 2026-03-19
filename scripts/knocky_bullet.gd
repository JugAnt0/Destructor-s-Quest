extends CharacterBody2D

var knockback = Vector2.ZERO
var speed = 150
var direction = Vector2.ZERO

func _physics_process(delta):
	rotation = direction.angle()
	 
	var collision = move_and_collide(direction * speed * delta)

	if collision:
		var body = collision.get_collider()

		if body.is_in_group("player"):
			body.knockback_to_self = (body.global_position - global_position).normalized() * 150
			Stats.vida -= 1
		queue_free()
