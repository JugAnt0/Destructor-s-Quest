extends Node2D


var last_health = Stats.vida


	
func _on_bullet_limit_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_bullet"):
		body.queue_free()
		
func _on_bullet_limit_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_bullet"):
		body.queue_free()
		
func _on_bullet_limit_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_bullet"):
		body.queue_free()
		
func _on_bullet_limit_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_bullet"):
		body.queue_free()
func _ready() -> void:
	Limits.down_limit = 217
	Limits.right_limit = 384
	Limits.left_limit = 0
	LevelManager.set_next_level("res://scenes/level_2.tscn")
	Stats.max_vida = Stats.d_max_vida
	Stats.vida = Stats.d_vida
	Stats.daño = Stats.d_daño
	Stats.velocidad = Stats.d_velocidad
	Stats.reload_speed = Stats.d_reload_speed
	Stats.propulsion_distance = Stats.d_propulsion_distance
	Stats.propulsion_reload_time = Stats.d_propulsion_reload_time
	Stats.piercing = Stats.d_piercing
	Stats.bullets_per_shot = Stats.d_bullets_per_shot
	Stats.alcance = Stats.d_alcance
	Stats.knockback = Stats.d_knockback
	Stats.player_knockback = Stats.d_player_knockback


func _process(_delta: float) -> void:
	
	# Detect when player loses health
	if Stats.vida < last_health:
		play_explosion(last_health)

	# Update UI hearts
	update_hearts()

	# Save current health
	last_health = Stats.vida
	if get_tree().get_nodes_in_group("enemy").size() <= 0:
		LevelManager.load_upgrade()

func play_explosion(heart_index):
	match heart_index:
		5:
			Hearts.hert_explosion5.show()
			Hearts.hert_explosion5.restart()
		4:
			Hearts.hert_explosion4.show()
			Hearts.hert_explosion4.restart()
		3:
			Hearts.hert_explosion3.show()
			Hearts.hert_explosion3.restart()
		2:
			Hearts.hert_explosion2.show()
			Hearts.hert_explosion2.restart()
		1:
			Hearts.hert_explosion1.show()
			Hearts.hert_explosion1.restart()


func update_hearts():
	Hearts.heart_1.visible = Stats.vida >= 1
	Hearts.heart_2.visible = Stats.vida >= 2
	Hearts.heart_3.visible = Stats.vida >= 3
	Hearts.heart_4.visible = Stats.vida >= 4
	Hearts.heart_5.visible = Stats.vida >= 5
		
		
		
		
