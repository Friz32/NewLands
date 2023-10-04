class_name EntityAIComponent2D
extends Node2D

@export var nav_agent: NavigationAgent2D
@export var chase_area: Area2D

@export_range(0, 10, 0.05, "suffix:s", "hide_slider", "or_greater")
var idle_duration_min := 1.0

@export_range(0, 20, 0.05, "suffix:s", "hide_slider", "or_greater")
var idle_duration_max := 3.0

@export_range(0, 100, 0.1, "suffix:px", "hide_slider", "or_greater")
var wander_range_min := 20.0

@export_range(0, 100, 0.1, "suffix:px", "hide_slider", "or_greater")
var wander_range_max := 100.0

@export var idle_speed := 4.0
@export var chase_speed := 14.0
@export var deceleration := 0.2
@export var damage := 10.0
@export var attack_distance := 32.0

@onready var state_machine: QCStateMachine = $QCStateMachine
@onready var idle_timer: Timer = $IdleTimer
@onready var update_target: Timer = $UpdateTarget
@onready var attack_timer: Timer = $AttackTimer

var idle_state := QCState.new("idle")
var wander_state := QCState.new("wander")
var chase_state := QCState.new("chase")

var motion: Vector2
var target: Node2D

func _ready() -> void:
	idle_state.enter = idle_enter
	wander_state.enter = wander_enter
	wander_state.physics_process = movement
	chase_state.physics_process = movement
	chase_state.process = chase_process
	chase_state.enter = func():
		idle_timer.stop()
		update_target.start()
	chase_state.exit = func():
		update_target.stop()
	
	state_machine.change_state(idle_state)
	
	nav_agent.navigation_finished.connect(on_navigation_finished)
	
	chase_area.body_entered.connect(on_chase_area_body_entered)
	chase_area.body_exited.connect(on_chase_area_body_exited)

func idle_enter():
	idle_timer.start(randf_range(idle_duration_min, idle_duration_max))

func wander_enter():
	nav_agent.target_position = global_position + Vector2.from_angle(randf_range(0, TAU)) * randf_range(wander_range_min, wander_range_max)

func chase_process(delta):
	if global_position.distance_to(target.global_position) < attack_distance && attack_timer.is_stopped():
		attack_timer.start()
		target.get_node("HealthComponent").health -= damage

func movement(delta):
	var parent = get_parent()
	
	motion = to_local(nav_agent.get_next_path_position()).normalized()
	var speed = idle_speed if state_machine.current_state == idle_state else chase_speed
	parent.velocity += motion * speed
	
	parent.move_and_slide()
	parent.velocity = parent.velocity.lerp(Vector2.ZERO, deceleration)

func on_navigation_finished():
	if state_machine.current_state == wander_state:
		state_machine.change_state(idle_state)

func on_chase_area_body_entered(body: Node2D):
	if body.is_in_group("player"):
		target = body
		state_machine.change_state(chase_state)

func on_chase_area_body_exited(body: Node2D):
	if target == body:
		target = null
		state_machine.change_state(idle_state)

func on_idle_timer_timeout() -> void:
	state_machine.change_state(wander_state)

func on_update_target_timeout() -> void:
	nav_agent.target_position = target.global_position
