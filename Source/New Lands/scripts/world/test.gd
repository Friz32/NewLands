extends Node2D

@onready var cave_warp := $YSort/CaveWarp

func _ready() -> void:
#	var gen = ProcGenCave.new()
#	gen.entrance_global_position = cave_warp.position
#	var s = gen.generate()
#	cave_warp.scene = s
#	cave_warp.player_position = gen.exit_global_position
	
	SaveSystem.save_data.player_scene = "res://scenes/world/test.tscn"
	SaveSystem.save_data.player_position = Vector2(100, 100)
	SaveSystem.save_data.player_parent = "YSort"
	
	var cnt = InvSystem.cnt
	cnt.add_item(Res["item_heal_potion"], 10)
	cnt.add_item(preload("uid://c5v8e435vfy5b"))
	cnt.add_item(preload("uid://34wqbd0yoghe"))
	cnt.add_item(preload("uid://sfxrfncyqaru"))
	cnt.add_item(preload("uid://dam3qsqj42irj"), 100)
	InvSystem.update()
