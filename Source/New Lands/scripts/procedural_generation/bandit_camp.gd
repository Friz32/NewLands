class_name ProcGenBanditCamp
extends RefCounted

var owner: Node2D
var parent: Node2D

func generate() -> Node2D:
	var root = Node2D.new()
	parent.add_child(root)
	root.owner = owner
	
	var campfire = preload("res://scenes/objects/campfire.tscn").instantiate()
	root.add_child(campfire)
	campfire.owner = owner
	
	return root
