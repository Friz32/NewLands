extends StaticBody2D

@export_file var scene := ""
@export var player_position: Vector2
@export var player_parent: NodePath

@onready var warp: Warp = $Warp

func on_interact() -> void:
	if scene:
		warp.warp(load(scene), player_position, player_parent)
