extends Control

@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")
@onready var ItemStackGuiClass = preload("res://inventory folder/itemStackGui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var itemInHand: ItemStackGui


func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()


func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)


func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()


func onSlotClicked(slot):
	if slot.isEmpty():
		if !itemInHand: return
		insertItemInSlot(slot)
		return
	if !itemInHand:
		takeItemFromSlot(slot)
		return
	
	if slot.itemStackGui.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
		stackItems(slot)
		return
	swapItems(slot)


func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()


func insertItemInSlot(slot):
	var item = itemInHand
	remove_child(item)
	itemInHand = null
	slot.insert(item)


func swapItems(slot):
	var tempItem = slot.takeItem()
	insertItemInSlot(slot)
	itemInHand = tempItem
	add_child(itemInHand)
	updateItemInHand()


func stackItems(slot):
	var slotItem: ItemStackGui = slot.itemStackGui
	var maxAmount = slotItem.inventorySlot.item.maxAmountPrStack
	var totalAmount = slotItem.inventorySlot.amount + itemInHand.inventorySlot.amount
	
	if slotItem.inventorySlot.amount == maxAmount: # if slot already at max amount swap items
		swapItems(slot)
		return
	if totalAmount <= maxAmount: # if total is less than max amound add stacks
		slotItem.inventorySlot.amount = totalAmount
		remove_child(itemInHand)
		itemInHand = null
	else: # if holding greater than allowed to add, add some, holder rest
		slotItem.inventorySlot.amount = maxAmount
		itemInHand.inventorySlot.amount = totalAmount - maxAmount
	
	slotItem.update()
	if itemInHand: itemInHand.update()

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2


func _input(event):
	updateItemInHand()
	if event.is_action_pressed("toggle_inventory"):
		visible = !visible
