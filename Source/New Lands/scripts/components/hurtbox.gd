class_name Hurtbox
extends Area2D

@export var damage := 20.0
@export var knockback_vector := Vector2(1000, 0)

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area):
	if area is Hitbox && area.owner != owner:
		area.health_component.health -= damage
		
		if area.owner is CharacterBody2D:
			area.owner.velocity += knockback_vector.rotated(global_rotation)
