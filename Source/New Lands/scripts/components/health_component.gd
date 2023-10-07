class_name HealthComponent
extends Node

signal died
signal damaged
signal health_changed

@export var max_health := 100.0
@export var health := 100.0:
	set(value):
		var previous_health = health
		health = clamp(value, 0, max_health)
		
		if previous_health > value:
			damaged.emit()
		
		if previous_health != value:
			health_changed.emit()
		
		if health <= 0:
			died.emit()
