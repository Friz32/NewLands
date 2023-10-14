class_name InvItem
extends Resource

@export var name := ""
@export var icon: Texture
@export var weight := 0.0
@export var tags: PackedStringArray
@export_multiline var description := ""

var use: Callable
