extends TextureButton

@onready var knockback_upgrade: TextureButton = $"."

@onready var sound: AudioStreamPlayer2D = $sound

@onready var description: Label = $description

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if knockback_upgrade.is_hovered() == true:
		description.show()
	else:
		description.hide()

func _on_pressed() -> void:
	Stats.player_knockback += 95
	sound.play()
	await get_tree().create_timer(0.2).timeout
	LevelManager.go_to_next_level()
	Hearts.hearts.show()
