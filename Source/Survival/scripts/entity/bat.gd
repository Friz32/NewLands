extends CharacterBody2D

@onready var entity_ai: EntityAIComponent2D = $EntityAIComponent2D
@onready var sprite: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	sprite.flip_h = entity_ai.motion.x < 0

func on_died() -> void:
	queue_free()
