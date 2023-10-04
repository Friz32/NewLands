class_name HealthComponent
extends Node

signal died
signal damaged

@export var max_health := 100.0
@export var health := 100.0:
	set(value):
		var previous_health = health
		health = value
		
		if previous_health > value:
			damaged.emit()
		
		if health <= 0:
			died.emit()
