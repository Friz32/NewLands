extends Node2D

func _ready() -> void:
	var polygon = NavigationPolygon.new()
	var size = 10000
	polygon.add_outline([
		Vector2(0, 0),
		Vector2(size, 0),
		Vector2(size, size),
		Vector2(0, size)
	])
	polygon.make_polygons_from_outlines()
	$NavigationRegion2D.navigation_polygon = polygon
