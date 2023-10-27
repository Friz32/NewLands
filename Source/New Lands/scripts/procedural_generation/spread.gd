class_name PGenSpread
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
