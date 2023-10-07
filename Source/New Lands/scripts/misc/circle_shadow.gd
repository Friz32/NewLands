@tool
class_name CircleShadow
extends Node2D

@export_range(0, 10, 0.1, "hide_slider", "or_greater") var radius := 10.0:
	set(value):
		radius = value
		queue_redraw()
@export var y_scale := 0.5:
	set(value):
		y_scale = value
		queue_redraw()
@export var alpha := 0.5:
	set(value):
		alpha = value
		queue_redraw()

func _draw() -> void:
	draw_set_transform(Vector2.ZERO, 0, Vector2(1, y_scale))
	draw_circle(Vector2.ZERO, radius, Color(0, 0, 0, alpha))
