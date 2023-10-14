class_name Interaction
extends Area2D

signal interact
signal interactor_exited

func _ready() -> void:
	area_exited.connect(on_area_exited)

func on_area_exited(area):
	if area is Interactor:
		interactor_exited.emit()
