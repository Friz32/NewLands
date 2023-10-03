class_name TDCPlayer
extends CharacterBody2D

@export var move_speed := 20.0
@export var deceleration := 0.2

@onready var anim_tree := $AnimationTree
@onready var playback = anim_tree["parameters/playback"]
@onready var hurtbox: Hurtbox = %Hurtbox
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var hurtbox_pivot: Node2D = $HurtboxPivot
@onready var audio_attack: AudioStreamPlayer = $AudioAttack

func _ready() -> void:
	hurtbox.monitoring = false
	hurtbox_pivot.visible = true
	hurtbox.get_node("Sprite2D").visible = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("attack") && attack_cooldown.is_stopped():
		hurtbox.monitoring = true
		hurtbox.get_node("Sprite2D").visible = true
		attack_cooldown.start()
		hurtbox_pivot.rotation = (get_local_mouse_position() - hurtbox_pivot.position).angle()
		audio_attack.play()
		
		await get_tree().create_timer(0.1).timeout
		
		hurtbox.monitoring = false
		hurtbox.get_node("Sprite2D").visible = false

func _physics_process(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	velocity += input * move_speed
	move_and_slide()
	velocity = velocity.lerp(Vector2.ZERO, deceleration)
	
	if input.length() > 0:
		playback.travel("move")
		
		anim_tree["parameters/idle/blend_position"] = input
		anim_tree["parameters/move/blend_position"] = input
	else:
		playback.travel("idle")
