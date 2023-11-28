extends PanelContainer

@onready var items: Container = %Items
@onready var weight: Label = %Weight

func _ready() -> void:
	update()

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


