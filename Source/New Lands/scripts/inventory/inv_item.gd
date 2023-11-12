class_name InvItem
extends Resource

@export var name := ""
@export var icon: Texture2D
@export var weight := 0.0
@export var tags: PackedStringArray
@export var equip_slot := ""
@export var equip_scene: PackedScene
@export_multiline var description := ""

var use: Callable
