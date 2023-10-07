extends Control

@onready var use: BaseButton = %Use

var item: InvItem

func update():
	use.visible = !item.use.is_null()

func on_use_pressed() -> void:
	item.use.call()

func on_trash_pressed() -> void:
	InvSystem.cnt.remove_item(item)
	InvSystem.update()
	
	var node = Res["scn_drop"].instantiate()
	node.item = item
	var player = get_tree().get_first_node_in_group("player")
	node.global_position = player.global_position
	get_tree().current_scene.add_child(node)
