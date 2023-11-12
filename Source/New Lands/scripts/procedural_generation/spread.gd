class_name ProcGenSpread
extends RefCounted

const CHUNK_SIZE = Chunks.CHUNK_SIZE_2D

var seed := -1

func generate(x, y) -> PackedScene:
	var root = Node2D.new()
	root.name = "Node2D"
	root.y_sort_enabled = true
	
	var component = Res["scn_chunk_component"].instantiate()
	root.add_child(component)
	component.owner = root
	
	if seed < 0:
		randomize()
	else:
		seed(seed)
	
	spread(x, y, root, 16, preload("uid://b2qxh4fwreulj"), -0.8, Res["scn_tree"], 64)
	spread(x, y, root, 16, preload("uid://buiwmm73ow5ep"), -0.4, Res["scn_rock"], 32)
	spread(x, y, root, 32, preload("uid://13yc2ds1sks2"), 0.6, Res["scn_berry_bush"], 32, func(node):
		node.berries = randf() < 0.2
	)
	
	random(root, 5, 12, Res["scn_wolf"])
	
	DirAccess.make_dir_absolute("user://saves")
	DirAccess.make_dir_absolute("user://saves/default")
	DirAccess.make_dir_absolute("user://saves/default/caves")
	for i in max(0, randi_range(1, 8)):
		var position = Vector2(randf() * CHUNK_SIZE, randf() * CHUNK_SIZE)
		var cave_warp = preload("res://scenes/objects/cave_warp.tscn").instantiate()
		cave_warp.position = position
		var gen = ProcGenCave.new()
		gen.entrance_scene = "res://scenes/world/world.tscn"
		gen.entrance_global_position = Vector2(x, y) * CHUNK_SIZE + position
		gen.entrance_parent = "ChunkManager2D"
		var scene = gen.generate()
		var path = "user://saves/default/caves/%s.%s.%s.scn" % [x, y, i]
		ResourceSaver.save(scene, path)
		cave_warp.scene = path
		cave_warp.player_position = gen.exit_global_position
		cave_warp.player_parent = "YSort"
		root.add_child(cave_warp)
		cave_warp.owner = root
	
	seed(0)
	
	var scene = PackedScene.new()
	scene.pack(root)
	return scene

func spread(x, y, root, cell_count, noise, value, scene, offset, handler := Callable()):
	for xx in cell_count:
		for yy in cell_count:
			var ax = CHUNK_SIZE / cell_count * xx
			var ay = CHUNK_SIZE / cell_count * yy
			var bx = ax + x * CHUNK_SIZE
			var by = ay + y * CHUNK_SIZE
			
			if noise.get_noise_2d(bx, by) < value:
				continue
			
			var node = scene.instantiate()
			var offset_vector = Vector2(randf_range(-offset, offset), randf_range(-offset, offset))
			node.position = Vector2(ax, ay) + offset_vector
			root.add_child(node)
			node.owner = root
			
			if !handler.is_null():
				handler.call(node)

func random(root, min, max, scene):
	for i in randf_range(min, max):
		var node = scene.instantiate()
		node.position = Vector2(randf_range(0, CHUNK_SIZE), randf_range(0, CHUNK_SIZE))
		root.add_child(node)
		node.owner = root
