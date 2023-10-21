extends Node2D

@export var item: InvItem
@export var count := 1

@onready var mesh_instance: MeshInstance2D = $MeshInstance2D

func _ready() -> void:
	if item.icon:
		mesh_instance.texture = item.icon

func on_interact() -> void:
	InvSystem.cnt.add_item(item, count)
	InvSystem.update()
	queue_free()
