extends CanvasLayer

func on_inventory_pressed() -> void:
	var node = get_tree().get_first_node_in_group("inventory")
	node.visible = !node.visible
