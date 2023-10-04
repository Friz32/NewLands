extends Control

func generate(x, y):
	const CHUNK_SIZE = 2048
	const MIN_WOLF_COUNT = 5
	const MAX_WOLF_COUNT = 12
	
	var root = Node2D.new()
	root.name = "Node2D"
	root.y_sort_enabled = true
	
#	var component = Res["scn_chunk_component"].instantiate()
#	root.add_child(component)
#	component.owner = root
	
	randomize()
	
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	noise.fractal_type = FastNoiseLite.FRACTAL_NONE
	noise.cellular_distance_function = FastNoiseLite.DISTANCE_EUCLIDEAN_SQUARED
	noise.cellular_jitter = 1.13
	noise.cellular_return_type = FastNoiseLite.RETURN_DISTANCE2_MUL
	noise.frequency = 0.015
	
	var a = 16
	
	for xx in a:
		for yy in a:
			var ax = CHUNK_SIZE / a * xx
			var ay = CHUNK_SIZE / a * yy
			var bx = ax + x * CHUNK_SIZE
			var by = ay + y * CHUNK_SIZE
			
			if noise.get_noise_2d(bx, by) < -0.8:
				continue
			
			var tree = Res["scn_tree"].instantiate()
			var aa = 64
			var offset = Vector2(randf_range(-aa, aa), randf_range(-aa, aa))
			tree.position = Vector2(ax, ay) + offset
			root.add_child(tree)
			tree.owner = root
	
	var rock_noise = FastNoiseLite.new()
	rock_noise.seed = randi()
	rock_noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	rock_noise.fractal_type = FastNoiseLite.FRACTAL_NONE
	rock_noise.frequency = 0.007
	
	for xx in a:
		for yy in a:
			var ax = CHUNK_SIZE / a * xx
			var ay = CHUNK_SIZE / a * yy
			var bx = ax + x * CHUNK_SIZE
			var by = ay + y * CHUNK_SIZE
			
			if rock_noise.get_noise_2d(bx, by) < -0.4:
				continue
			
			var tree = Res["scn_rock"].instantiate()
			var aa = 32
			var offset = Vector2(randf_range(-aa, aa), randf_range(-aa, aa))
			tree.position = Vector2(ax, ay) + offset
			root.add_child(tree)
			tree.owner = root
	
	for i in randf_range(MIN_WOLF_COUNT, MAX_WOLF_COUNT):
		var node = Res["scn_wolf"].instantiate()
		node.position = Vector2(randf_range(0, CHUNK_SIZE), randf_range(0, CHUNK_SIZE))
		root.add_child(node)
		node.owner = root
	
	seed(0)
	
	var scene = PackedScene.new()
	scene.pack(root)
	DirAccess.make_dir_absolute("user://world")
	ResourceSaver.save(scene, "user://world/%s.%s.scn" % [x, y])

func on_new_game_pressed() -> void:
	for x in 4:
		for y in 4:
			generate(x, y)
	
	get_tree().change_scene_to_file("res://scenes/test.tscn")

func on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test.tscn")
