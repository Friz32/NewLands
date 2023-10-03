extends Node

var cnt := InvContainer.new()

func update():
	get_tree().get_first_node_in_group("inventory").update()
