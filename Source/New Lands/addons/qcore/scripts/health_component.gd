class_name QCHealthComponent
extends Node

signal died

@export var max_health := 1.0:
	set(value):
		max_health = value
		if current_health > max_health:
			current_health = max_health

var current_health := 1.0:
	set(value):
		current_health = clamp(value, 0, max_health)
		
		if current_health <= 0:
			died.emit()

var is_alive: bool:
	get:
		return current_health > 0

var is_damaged: bool:
	get:
		return current_health < max_health

func _ready():
	current_health = max_health
