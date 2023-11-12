extends Control

@onready var ip: LineEdit = %IP
@onready var seed: LineEdit = %Seed

func on_new_game_pressed() -> void:
	for x in range(-4, 4):
		for y in range(-4, 4):
			var gen = ProcGenSpread.new()
			if !seed.text.is_empty():
				gen.seed = seed.text
			var scene = gen.generate(x, y)
			DirAccess.make_dir_absolute("user://saves")
			DirAccess.make_dir_absolute("user://saves/default")
			DirAccess.make_dir_absolute("user://saves/default/world")
			ResourceSaver.save(scene, "user://saves/default/world/%s.%s.scn" % [x, y])

	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")
	
	var save = SaveSystem.save_data
	save.player_scene = Res["scn_world"]
	save.player_parent = "ChunkManager2D"

func on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")
	
	var save = SaveSystem.save_data
	save.player_scene = Res["scn_world"]
	save.player_parent = "ChunkManager2D"

func on_connect_to_server_pressed() -> void:
	Networking.create_client(ip.text)
	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")
