extends TextureButton

@onready var pierce_upgrade: TextureButton = $"."



@onready var description: Label = $description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if pierce_upgrade.is_hovered() == true:
		description.show()
	else:
		description.hide()


func _on_pressed() -> void:
	Stats.piercing += 1
	LevelManager.go_to_next_level()
	Hearts.hearts.show()
