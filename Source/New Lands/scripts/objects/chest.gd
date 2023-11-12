extends StaticBody2D

func on_interact() -> void:
	var interface = get_tree().get_first_node_in_group("hud").get_node("%ObjectInterface")

	for child in interface.get_children():
		child.queue_free()

	var node = preload("res://scenes/ui/inv_container.tscn").instantiate()
	node.get_node("%Title").text = "Chest"
	interface.add_child(node)

func on_interactor_exited() -> void:
	var interface = get_tree().get_first_node_in_group("hud").get_node("%ObjectInterface")
	for child in interface.get_children():
		child.queue_free()
