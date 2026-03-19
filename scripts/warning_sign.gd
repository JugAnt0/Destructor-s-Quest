extends Control

var target: Node2D
var camera: Camera2D
@onready var arrow = $Danger

func _process(_delta):

	if target == null or camera == null:
		return

	var screen_size = get_viewport_rect().size
	var center = screen_size / 2

	var dir = (target.global_position - camera.global_position).normalized()

	var margin = 50
	var pos = center + dir * (min(center.x, center.y) - margin)

	position = pos
	arrow.rotation = dir.angle()

	var cam_rect = Rect2(
		camera.global_position - (screen_size * camera.zoom) / 2,
		screen_size * camera.zoom
	)

	if cam_rect.has_point(target.global_position):
		hide()
	else:
		show()
