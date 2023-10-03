extends StaticBody2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func on_died() -> void:
	queue_free()
	InvSystem.cnt.add_item(Res["item_log"], 2)
	InvSystem.update()

func on_damaged() -> void:
	anim_player.play("damaged")
