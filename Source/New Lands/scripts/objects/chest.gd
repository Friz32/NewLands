extends StaticBody2D

func on_interact() -> void:
	var interface = get_tree().get_first_node_in_group("hud").get_node("%ObjectInterface")

	for child in interface.get_children():
		child.queue_free()

	var node = Panel.new()
	node.custom_minimum_size = Vector2(100, 100)
	interface.add_child(node)

func on_interactor_exited() -> void:
	var interface = get_tree().get_first_node_in_group("hud").get_node("%ObjectInterface")
	for child in interface.get_children():
		child.queue_free()
