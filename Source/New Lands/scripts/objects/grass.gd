extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.flip_h = randi() % 2 > 0
