extends PanelContainer

@onready var item_name: Label = %Name
@onready var icon: TextureRect = %Icon

var item: InvItem

func update():
	item_name.text = item.name
	
	if item.icon:
		icon.texture = item.icon

func on_remove_pressed() -> void:
	InvSystem.equipment.erase(item.equip_slot)
	InvSystem.update_equipment()
