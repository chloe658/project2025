extends Resource

class_name Inventory
signal updated

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
	slots[index] = InventorySlot.new()

func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
