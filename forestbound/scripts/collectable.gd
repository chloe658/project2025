extends Area2D

@export var itemRes: InventoryItem
@export var slots: Array[InventorySlot]


func collect(inventory: Inventory):
	"""
	var emptySlots = slots.filter(func (s): return s.isEmpty)
	if emptySlots.is_empty(): return
	"""
	# TO DO: do not pick up items if inventory is full
	inventory.insert(itemRes)
	queue_free()
