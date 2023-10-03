class_name QCStateMachine
extends Node

var current_state: QCState

func _process(delta: float) -> void:
	if current_state && !current_state.process.is_null():
		current_state.process.call(delta)

func _physics_process(delta: float) -> void:
	if current_state && !current_state.physics_process.is_null():
		current_state.physics_process.call(delta)

func change_state(state: QCState):
	if current_state && !current_state.exit.is_null():
		current_state.exit.call()
	
	if !state.enter.is_null():
		state.enter.call()
	
	current_state = state
