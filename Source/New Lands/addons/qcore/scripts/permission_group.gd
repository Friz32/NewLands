class_name QCPermissionGroup
extends Resource

@export var name := ""
@export var weight := 0
@export_multiline var info := ""
@export var permissions: Array[QCPermission]

func check(node: String):
	for perm in permissions:
		if perm.node == node && perm.value:
			return true
