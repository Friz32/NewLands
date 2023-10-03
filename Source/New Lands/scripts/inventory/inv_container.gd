class_name InvContainer
extends RefCounted

var items := {}

func add_item(item: InvItem, count := 1):
	if !items.has(item):
		items[item] = count
	else:
		items[item] += count

func get_weight() -> float:
	var weight = 0
	for item in items:
		weight += item.weight * items[item]
	
	return weight
