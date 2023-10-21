extends Control

@onready var ip: LineEdit = %IP

func generate(x, y):
	const CHUNK_SIZE = 2048

	var root = Node2D.new()
	root.name = "Node2D"
	root.y_sort_enabled = true

	var spread = func(cell_count, noise, value, scene, offset, handler := Callable()):
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

	var random = func(min, max, scene):
		for i in randf_range(min, max):
			var node = scene.instantiate()
			node.position = Vector2(randf_range(0, CHUNK_SIZE), randf_range(0, CHUNK_SIZE))
			root.add_child(node)
			node.owner = root

#	var component = Res["scn_chunk_component"].instantiate()
#	root.add_child(component)
#	component.owner = root

	randomize()

	spread.call(16, preload("uid://b2qxh4fwreulj"), -0.8, Res["scn_tree"], 64)
	spread.call(16, preload("uid://buiwmm73ow5ep"), -0.4, Res["scn_rock"], 32)
	spread.call(32, preload("uid://13yc2ds1sks2"), 0.6, Res["scn_berry_bush"], 32, func(node):
		node.berries = randf() < 0.2
	)

	random.call(5, 12, Res["scn_wolf"])

	seed(0)

	var scene = PackedScene.new()
	scene.pack(root)
	DirAccess.make_dir_absolute("user://world")
	ResourceSaver.save(scene, "user://world/%s.%s.scn" % [x, y])

func on_new_game_pressed() -> void:
	for x in 4:
		for y in 4:
			generate(x, y)

	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")

func on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")

func on_connect_to_server_pressed() -> void:
	Networking.create_client(ip.text)
