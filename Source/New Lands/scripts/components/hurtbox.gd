class_name Hurtbox
extends Area2D

@export var damage := 20.0

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area):
	if area is Hitbox:
		area.health_component.health -= damage
