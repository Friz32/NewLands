extends Node

var cnt := InvContainer.new()
var equipment := {} # String, InvItem

func update():
	get_tree().get_first_node_in_group("inventory").update()

func update_equipment():
	get_tree().get_first_node_in_group("inventory").update_equipment()
