extends Control

@onready var ip: LineEdit = %IP
@onready var seed: LineEdit = %Seed
@onready var sub_menu: TabContainer = %SubMenu

func _ready() -> void:
	sub_menu.visible = false
	seed.text = str(randi())

func on_new_game_pressed() -> void:
	sub_menu.visible = true
	sub_menu.current_tab = 0

func on_load_game_pressed() -> void:
	get_tree().change_scene_to_file(SaveSystem.save_data.player_scene)

func on_connect_to_server_pressed() -> void:
	sub_menu.visible = true
	sub_menu.current_tab = 1

func on_connect_pressed() -> void:
	Networking.create_client(ip.text)
	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")

func on_create_pressed() -> void:
	for x in range(-4, 4):
		for y in range(-4, 4):
			var gen = ProcGenSpread.new()
			if !seed.text.is_empty():
				gen.seed = seed.text
			var path = "user://saves/default/world/%s.%s.scn" % [x, y]
			gen.path = path
			var scene = gen.generate(x, y)
			DirAccess.make_dir_recursive_absolute("user://saves/default/world")
			ResourceSaver.save(scene, path)

	get_tree().change_scene_to_file("uid://6nhd6mhc8dsh")

	var save = SaveSystem.save_data
	save.player_scene = "res://scenes/world/world.tscn"
	save.player_parent = "ChunkManager2D"

func on_quit_pressed() -> void:
	get_tree().quit()
