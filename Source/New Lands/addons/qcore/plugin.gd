@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("QC", "res://addons/qcore/scenes/system.tscn")

func _exit_tree():
	remove_autoload_singleton("QC")
