class_name Interactor
extends Area2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pick_up_item"):
		for area in get_overlapping_areas():
			if area is Interaction:
				area.interact.emit()
				break
