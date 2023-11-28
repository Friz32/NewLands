extends PanelContainer

@onready var equipment: Container = %Equipment

func _ready() -> void:
	update()

func update():
	for child in equipment.get_children():
		child.queue_free()
	
	for slot in InvSystem.equipment:
		var node = Res["scn_inv_equipment"].instantiate()
		node.item = InvSystem.equipment[slot]
		equipment.add_child(node)
		node.update()
