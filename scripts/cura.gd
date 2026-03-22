extends TextureButton

@onready var sound: AudioStreamPlayer2D = $sound

@onready var cura: TextureButton = $"."

@onready var description: Label = $description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if cura.is_hovered() == true:
		description.show()
	else:
		description.hide()


func _on_pressed() -> void:
	sound.play()
	await get_tree().create_timer(0.2).timeout
	if Stats.vida < Stats.max_vida:
		if (Stats.max_vida - Stats.vida)<= 3:
			Stats.vida += Stats.max_vida - Stats.vida
		else:
			Stats.vida += 3
	else:
		pass
	LevelManager.go_to_next_level()
	Hearts.hearts.show()
	
