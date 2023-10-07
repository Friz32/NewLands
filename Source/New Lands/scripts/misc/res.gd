extends ResourcePreloader

func _ready() -> void:
	get("item_heal_potion").use = func():
		get_tree().get_first_node_in_group("player").health_component.health += 50
		InvSystem.cnt.remove_item(get("item_heal_potion"))
		InvSystem.update()
		QC.audio_play(Res["sfx_heal"])

func _get(property: StringName):
	return get_resource(property)
