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
	Limits.down_limit =300
	Limits.right_limit = 450
	LevelManager.set_next_level("res://scenes/level_3.tscn")
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
		10:
			Hearts.hert_explosion10.show()
			Hearts.hert_explosion10.restart()
		9:
			Hearts.hert_explosion9.show()
			Hearts.hert_explosion9.restart()
		8:
			Hearts.hert_explosion8.show()
			Hearts.hert_explosion8.restart()
		7:
			Hearts.hert_explosion7.show()
			Hearts.hert_explosion7.restart()
		6:
			Hearts.hert_explosion6.show()
			Hearts.hert_explosion6.restart()
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
	Hearts.heart_6.visible = Stats.vida >= 6
	Hearts.heart_7.visible = Stats.vida >= 7
	Hearts.heart_8.visible = Stats.vida >= 8
	Hearts.heart_9.visible = Stats.vida >= 9
	Hearts.heart_10.visible = Stats.vida >= 10
