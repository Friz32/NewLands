extends Node

var save_data := SaveData.new()

func _ready() -> void:
	if FileAccess.file_exists("user://saves/default/save.res"):
		save_data = load("user://saves/default/save.res")

func _exit_tree() -> void:
	ResourceSaver.save(save_data, "user://saves/default/save.res")

func update_player_data():
	var player = get_tree().get_first_node_in_group("player")
	save_data.player_scene = get_tree().current_scene.scene_file_path
	save_data.player_position = player.position
	save_data.player_parent = player.get_parent().get_path()
