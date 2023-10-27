extends VBoxContainer

@onready var items: Container = %Items
@onready var weight: Label = %Weight
@onready var equipment: Container = %Equipment

func _ready() -> void:
	update()
	update_equipment()

func update():
	for child in items.get_children():
		child.queue_free()

	var cnt = InvSystem.cnt

	for item in cnt.items:
		var node = Res["scn_inv_item"].instantiate()
		node.item = item
		items.add_child(node)
		node.update()

	weight.text = "Weight: %s/100" % cnt.get_weight()

func update_equipment():
	for child in equipment.get_children():
		child.queue_free()
	
	for slot in InvSystem.equipment:
		var node = Res["scn_inv_equipment"].instantiate()
		node.item = InvSystem.equipment[slot]
		equipment.add_child(node)
		node.update()
