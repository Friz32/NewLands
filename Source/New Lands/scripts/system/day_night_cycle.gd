extends CanvasModulate

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	anim_player.seek(System.time * 24)
