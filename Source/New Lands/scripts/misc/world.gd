extends Node2D

func _ready() -> void:
	var polygon = NavigationPolygon.new()
	var rect = Rect2(-9000, -9000, 18000, 18000)
	polygon.add_outline([
		Vector2(rect.position.x, rect.position.y),
		Vector2(rect.size.x, rect.position.y),
		Vector2(rect.size.x, rect.size.y),
		Vector2(rect.position.x, rect.size.y)
	])
	polygon.make_polygons_from_outlines()
	$NavigationRegion2D.navigation_polygon = polygon
