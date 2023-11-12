class_name ProcGenCave
extends RefCounted

var entrance_scene := ""
var entrance_global_position: Vector2
var entrance_parent: NodePath
var exit_global_position: Vector2

func generate() -> PackedScene:
	var root = Node2D.new()
	
	var template = Res["scn_cave_template%s" % randi_range(1, 2)].instantiate()
#	template.rotation = randf() * TAU
	root.add_child(template)
	template.owner = root
	
	var ysort = Node2D.new()
	ysort.name = "YSort"
	ysort.y_sort_enabled = true
	root.add_child(ysort)
	ysort.owner = root
	
	exit_global_position = template.get_node("Exit").get_child(randi() % template.get_node("Exit").get_child_count()).position
#	exit_global_position = template.get_node("Exit").get_child(randi() % 3).global_position
	
	var warp = preload("res://scenes/objects/cave_warp.tscn").instantiate()
	warp.scene = entrance_scene
	warp.player_position = entrance_global_position
	warp.player_parent = entrance_parent
	warp.position = exit_global_position
	ysort.add_child(warp)
	warp.owner = root
	
	var scene = PackedScene.new()
	scene.pack(root)
	return scene
