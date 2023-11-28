class_name Warp
extends Area2D

@export var scene: PackedScene
@export var player_position: Vector2
@export var player_parent: NodePath

func _ready() -> void:
	body_entered.connect(on_body_entered)

func warp(scene, player_position, player_parent):
	var save = SaveSystem.save_data
	save.player_scene = scene.resource_path
	save.player_position = player_position
	save.player_parent = player_parent
	
	get_tree().change_scene_to_packed(scene)
	System.transition.get_node("AnimationPlayer").play("fade_in")

func on_body_entered(body):
	if body is TDCPlayer:
		warp(scene, player_position, player_parent)
