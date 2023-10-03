extends StaticBody2D

@onready var particles: GPUParticles2D = $GPUParticles2D

func on_died() -> void:
	queue_free()
	InvSystem.cnt.add_item(Res["item_stone"], 1)
	InvSystem.update()

func on_damaged() -> void:
	particles.restart()
	particles.emitting = true
