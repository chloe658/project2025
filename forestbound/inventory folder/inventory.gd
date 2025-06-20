extends Resource

class_name Inventory
signal updated

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item:
			# dont add items past stack limit
			if slot.amount >= slot.item.stackSize:
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
