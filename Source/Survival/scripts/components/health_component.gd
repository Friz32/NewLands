class_name HealthComponent
extends Node

signal died
signal damaged

@export var max_health := 100.0
@export var health := 100.0:
	set(value):
		if health > value:
			damaged.emit()
		
		health = value
		
		if health < 0:
			died.emit()
