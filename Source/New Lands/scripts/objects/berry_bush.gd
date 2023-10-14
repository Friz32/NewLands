extends Node2D

@export var berries := true

@onready var overlay: Sprite2D = $Overlay

func _ready() -> void:
	overlay.visible = berries

func on_interact() -> void:
	if overlay.visible:
		overlay.visible = false
		InvSystem.cnt.add_item(Res["item_berries"])
		InvSystem.update()
