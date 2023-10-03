class_name ChunkLoadingPosition2D
extends Node2D

@export var loading_distance := 1.0

func _enter_tree() -> void:
	var manager = get_tree().get_first_node_in_group("chunk_manager")
	manager.loading_positions.append(self)

func _exit_tree() -> void:
	var manager = get_tree().get_first_node_in_group("chunk_manager")
	var loading_positions = manager.loading_positions
	loading_positions.remove_at(loading_positions.find(self))
