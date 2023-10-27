extends Node

var time := 0.0

func on_timeout() -> void:
	time = wrap(time + 0.01, 0, 100)
