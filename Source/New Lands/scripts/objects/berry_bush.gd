extends Node2D

@export var berries := true

@onready var overlay: Sprite2D = $Overlay
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	overlay.visible = berries
	sprite.flip_h = randi() % 2 > 0

func on_interact() -> void:
	if overlay.visible:
		overlay.visible = false
		InvSystem.cnt.add_item(Res["item_berries"])
		InvSystem.update()

func on_died() -> void:
	queue_free()
