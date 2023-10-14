extends CanvasLayer

@onready var tab_container: TabContainer = %TabContainer

func _ready() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("character_menu_left"):
		tab_container.current_tab = wrap(tab_container.current_tab - 1, 0, tab_container.get_tab_count())
		get_viewport().set_input_as_handled()

	if event.is_action_pressed("character_menu_right"):
		tab_container.current_tab = wrap(tab_container.current_tab + 1, 0, tab_container.get_tab_count())
		get_viewport().set_input_as_handled()
	
	if InputMap.has_action("inventory") && event.is_action_pressed("inventory"):
		if !visible:
			get_tree().call_group("screen", "set_visible", false)
			visible = true
		elif tab_container.current_tab == tab_container.get_tab_idx_from_control(tab_container.get_node("Inventory")):
			var v = visible
			get_tree().call_group("screen", "set_visible", false)
			visible = !v
		
		tab_container.current_tab = tab_container.get_tab_idx_from_control(tab_container.get_node("Inventory"))
		
		get_viewport().set_input_as_handled()
	
	if InputMap.has_action("map") && event.is_action_pressed("map"):
		if !visible:
			get_tree().call_group("screen", "set_visible", false)
			visible = true
		elif tab_container.current_tab == tab_container.get_tab_idx_from_control(tab_container.get_node("Map")):
			var v = visible
			get_tree().call_group("screen", "set_visible", false)
			visible = !v
		
		tab_container.current_tab = tab_container.get_tab_idx_from_control(tab_container.get_node("Map"))
		
		get_viewport().set_input_as_handled()

func on_inventory_pressed() -> void:
	tab_container.current_tab = tab_container.get_tab_idx_from_control(tab_container.get_node("Inventory"))

func on_crafting_pressed() -> void:
	tab_container.current_tab = tab_container.get_tab_idx_from_control(tab_container.get_node("Crafting"))
