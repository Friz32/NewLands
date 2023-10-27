extends Node

var cnt := InvContainer.new()
var equipment := {} # String, InvItem

func _ready() -> void:
	cnt.add_item(Res["item_heal_potion"], 10)
	cnt.add_item(preload("uid://c5v8e435vfy5b"))
	cnt.add_item(preload("uid://34wqbd0yoghe"))
	cnt.add_item(preload("uid://sfxrfncyqaru"))
	cnt.add_item(preload("uid://dam3qsqj42irj"), 100)

func update():
	get_tree().get_first_node_in_group("inventory").update()

func update_equipment():
	get_tree().get_first_node_in_group("inventory").update_equipment()
