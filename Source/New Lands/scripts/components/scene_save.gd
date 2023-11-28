class_name SceneSaveComponent
extends Node

@export_file var path := ""

func _exit_tree() -> void:
	var scene = PackedScene.new()
	scene.pack(owner)
	ResourceSaver.save(scene, path)
