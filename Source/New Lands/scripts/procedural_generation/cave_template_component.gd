@tool
class_name CaveTemplateComponent
extends Node

@export var walls_polygon: Polygon2D
@export var walls_collision_polygon: CollisionPolygon2D
@export var walls_light_occluder: LightOccluder2D

@export var update_polygon := false:
	set(value):
		walls_collision_polygon.polygon = walls_polygon.polygon
		
		var occluder = OccluderPolygon2D.new()
		occluder.cull_mode = OccluderPolygon2D.CULL_COUNTER_CLOCKWISE
		occluder.polygon = walls_polygon.polygon
		walls_light_occluder.occluder = occluder
