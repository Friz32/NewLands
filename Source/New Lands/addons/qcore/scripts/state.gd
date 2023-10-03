class_name QCState
extends RefCounted

var name := ""
var enter: Callable
var exit: Callable
var process: Callable
var physics_process: Callable

func _init(name := "") -> void:
	self.name = name
