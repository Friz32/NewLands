extends StaticBody2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func on_died() -> void:
	var node = Res["scn_drop"].instantiate()
	node.item = Res["item_log"]
	node.count = 2
	node.position = position
	get_parent().add_child(node)
	node.owner = owner
	
	queue_free()

func on_damaged() -> void:
	anim_player.play("damaged")
