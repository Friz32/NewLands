extends StaticBody2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func on_died() -> void:
	var node = Res["scn_drop"].instantiate()
	node.item = Res["item_log"]
	node.count = 2
	node.global_position = global_position
	get_tree().get_first_node_in_group("chunk_manager").add_child(node)
	
	queue_free()

func on_damaged() -> void:
	anim_player.play("damaged")
