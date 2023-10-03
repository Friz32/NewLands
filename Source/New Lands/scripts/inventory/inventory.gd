extends CanvasLayer

@onready var items: VBoxContainer = %Items
@onready var weight: Label = %Weight

func _ready() -> void:
	visible = false
	
	var cnt = InvSystem.cnt
	cnt.add_item(Res["item_log"])
	cnt.add_item(Res["item_stone"])
	
	update()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		update()

func _unhandled_input(event):
	if InputMap.has_action("inventory") && event.is_action_pressed("inventory"):
		var v = visible
		get_tree().call_group("screen", "set_visible", false)
		visible = !v
		
		get_tree().root.set_input_as_handled()

func update():
	for child in items.get_children():
		child.queue_free()
	
	var cnt = InvSystem.cnt
	
	for item in cnt.items:
		var node = Res["scn_inv_item"].instantiate()
		node.get_node("%Name").text = "%s (%s)" % [item.name, cnt.items[item]]
		node.get_node("%Icon").texture = item.icon
		node.tooltip_text = "Weight: %s (%s)" % [item.weight, item.weight * cnt.items[item]]
		items.add_child(node)
	
	weight.text = "Weight: %s/100" % cnt.get_weight()
