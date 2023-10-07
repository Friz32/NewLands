extends Node2D

@onready var overlay: Sprite2D = $Overlay

func on_interact() -> void:
	if overlay.visible:
		overlay.visible = false
		InvSystem.cnt.add_item(Res["item_berries"])
		InvSystem.update()
