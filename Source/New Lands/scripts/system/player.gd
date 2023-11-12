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
@onready var audio_hurt: AudioStreamPlayer = $AudioHurt
@onready var hud: CanvasLayer = $HUD
@onready var health_component: HealthComponent = $HealthComponent
@onready var visual: Node2D = $Visual

var health_regen := 0.01

func _ready() -> void:
	hud.visible = true

	hurtbox.monitoring = false
	hurtbox_pivot.visible = true
	hurtbox.get_node("Sprite2D").visible = false

	on_health_changed()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack") && attack_cooldown.is_stopped():
		hurtbox.monitoring = true
		hurtbox.get_node("Sprite2D").visible = true
		attack_cooldown.start()
		hurtbox_pivot.rotation = (get_local_mouse_position() - hurtbox_pivot.position).angle()
		audio_attack.play()

		await get_tree().create_timer(0.1).timeout

		hurtbox.monitoring = false
		hurtbox.get_node("Sprite2D").visible = false

func _process(delta: float) -> void:
	hud.get_node("%AttackCooldown").visible = attack_cooldown.time_left > 0
	hud.get_node("%AttackCooldown").value = attack_cooldown.time_left / attack_cooldown.wait_time * 100
	
	health_component.health += health_regen

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
	
#	# Освещение ломается когда scale имеет негативное значение
#	if input.x > 0:
#		visual.scale.x = 1
#	elif input.x < 0:
#		visual.scale.x = -1

func on_died() -> void:
	get_tree().reload_current_scene()

func on_damaged() -> void:
	audio_hurt.play()

func on_health_changed() -> void:
	hud.get_node("%HealthBar").value = health_component.health / health_component.max_health * 100
