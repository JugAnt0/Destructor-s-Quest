extends TextureButton

@onready var sound: AudioStreamPlayer2D = $sound

@onready var max_life_upgrade: TextureButton = $"."

@onready var description: Label = $description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if max_life_upgrade.is_hovered() == true:
		description.show()
	else:
		description.hide()


func _on_pressed() -> void:
	sound.play()
	await get_tree().create_timer(0.2).timeout
	Stats.max_vida += 1
	Stats.vida += 1
	LevelManager.go_to_next_level()
	Hearts.hearts.show()
	
