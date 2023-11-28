class_name ProcGenCave
extends RefCounted

var entrance_scene := ""
var entrance_global_position: Vector2
var entrance_parent: NodePath
var exit_global_position: Vector2
var path := ""

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
	
	var scene_save = SceneSaveComponent.new()
	scene_save.path = path
	root.add_child(scene_save)
	scene_save.owner = root
	
	exit_global_position = template.get_node("Exit").get_child(randi() % template.get_node("Exit").get_child_count()).position
#	exit_global_position = template.get_node("Exit").get_child(randi() % 3).global_position
	
	var warp = preload("res://scenes/objects/cave_warp.tscn").instantiate()
	warp.scene = entrance_scene
	warp.player_position = entrance_global_position
	warp.player_parent = entrance_parent
	warp.position = exit_global_position
	ysort.add_child(warp)
	warp.owner = root
	
	for point in template.get_node("Ore").get_children():
		if randf() > 0.5:
			var iron_ore = preload("res://scenes/objects/iron_ore.tscn").instantiate()
			iron_ore.position = point.position
			ysort.add_child(iron_ore)
			iron_ore.owner = root
	
	var scene = PackedScene.new()
	scene.pack(root)
	return scene
