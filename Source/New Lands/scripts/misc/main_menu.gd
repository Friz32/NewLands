extends Control

@onready var ip: LineEdit = %IP
@onready var seed: LineEdit = %Seed

func on_new_game_pressed() -> void:
	for x in 4:
		for y in 4:
			var gen = PGenSpread.new()
			if !seed.text.is_empty():
				gen.seed = seed.text
			var scene = gen.generate(x, y)
			DirAccess.make_dir_absolute("user://world")
			ResourceSaver.save(scene, "user://world/%s.%s.scn" % [x, y])

	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")

func on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")

func on_connect_to_server_pressed() -> void:
	Networking.create_client(ip.text)
