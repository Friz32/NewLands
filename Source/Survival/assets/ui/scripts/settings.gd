extends Control

@onready var item_list: ItemList = %ItemList
@onready var tab_container: TabContainer = %TabContainer

func _ready() -> void:
	item_list.select(0)

func _on_item_list_item_selected(index: int) -> void:
	var selected = item_list.get_item_text(index)
	var node = tab_container.get_node_or_null(selected)
	if node != null:
		tab_container.current_tab = node.get_index()
