extends StaticBody2D

@onready var particles: GPUParticles2D = $GPUParticles2D

func on_died() -> void:
	var node = Res["scn_drop"].instantiate()
	node.item = Res["item_stone"]
	node.global_position = global_position
	get_tree().get_first_node_in_group("chunk_manager").add_child(node)
	
	queue_free()

func on_damaged() -> void:
	particles.restart()
	particles.emitting = true
