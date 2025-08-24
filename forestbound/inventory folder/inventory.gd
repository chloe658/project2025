extends Resource

class_name Inventory
signal updated
signal use_item

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item:
			# dont add items past stack limit
			if slot.amount >= slot.item.maxAmountPrStack:
				continue
			slot.amount += 1
			updated.emit()
			return

	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount = 1
			updated.emit()
			return

func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	remove_at_index(index)


func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()

func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	updated.emit()


func use_item_at_index(index: int) -> void:
	if index < 0 or index >= slots.size() or !slots[index].item: return
	
	var slot = slots[index]
	use_item.emit(slot.item)
	
	if slot.item.maxAmountPrStack == 1: return # dont remove items with a max amount per stack of 1 because they are tools
	if slot.amount > 1:
		slot.amount -= 1
		updated.emit()
		return
	
	remove_at_index(index)
