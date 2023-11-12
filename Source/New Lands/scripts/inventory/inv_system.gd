extends Node

var cnt := InvContainer.new()
var equipment := {} # String, InvItem

func update():
	var inventory = get_tree().get_first_node_in_group("inventory")
	if inventory:
		inventory.update()

func update_equipment():
	var inventory = get_tree().get_first_node_in_group("inventory")
	if inventory:
		inventory.update_equipment()
