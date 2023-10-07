extends Node2D

@export var item: InvItem

@onready var mesh_instance: MeshInstance2D = $MeshInstance2D

func _ready() -> void:
	mesh_instance.texture = item.icon

func on_interact() -> void:
	InvSystem.cnt.add_item(item)
	InvSystem.update()
	queue_free()
