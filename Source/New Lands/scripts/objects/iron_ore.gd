extends StaticBody2D

@export var mined := false

@onready var overlay: Sprite2D = $Overlay
@onready var particles: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	overlay.visible = !mined

func on_died() -> void:
	if mined:
		return
	
	overlay.visible = false
	mined = true
	
	var node = Res["scn_drop"].instantiate()
	node.item = Res["item_iron_ore"]
	node.position = position
	get_parent().add_child(node)
	node.owner = owner

func on_damaged() -> void:
	if !mined:
		particles.restart()
		particles.emitting = true
