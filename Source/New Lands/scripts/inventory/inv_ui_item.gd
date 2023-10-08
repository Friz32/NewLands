extends Control

@onready var use: BaseButton = %Use
@onready var item_name: Label = %Name
@onready var icon: TextureRect = %Icon

var item: InvItem

func _ready() -> void:
	tooltip_text = "tooltip"

func _make_custom_tooltip(for_text: String) -> Object:
	var tooltip = Res["scn_tooltip"].instantiate()
	tooltip.get_node("%Icon").texture = item.icon
	
	var cnt = InvSystem.cnt
	
	var item_name = "%s (%s)" % [item.name, cnt.items[item]] if cnt.items[item] > 1 else item.name
	tooltip.get_node("%Name").text = item_name
	
	var weight_text = "Weight: %s (%s)" % [item.weight, item.weight * cnt.items[item]]
	tooltip.get_node("%Weight").text = weight_text
	
	tooltip.get_node("%Description").visible = item.description.length() > 0
	tooltip.get_node("%Description").text = item.description
	
	return tooltip

func update():
	var cnt = InvSystem.cnt
	
	var name = "%s (%s)" % [item.name, cnt.items[item]] if cnt.items[item] > 1 else item.name
	item_name.text = name
	
	icon.texture = item.icon
	
	use.visible = !item.use.is_null()

func on_use_pressed() -> void:
	item.use.call()

func on_trash_pressed() -> void:
	InvSystem.cnt.remove_item(item)
	InvSystem.update()
	
	var node = Res["scn_drop"].instantiate()
	node.item = item
	var player = get_tree().get_first_node_in_group("player")
	node.global_position = player.global_position
	get_tree().get_first_node_in_group("chunk_manager").add_child(node)
