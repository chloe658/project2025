extends Control

@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")
@onready var ItemStackGuiClass = preload("res://inventory folder/itemStackGui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var itemInHand = ItemStackGui

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()

func connectSlots():
	for slot in slots:
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

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		visible = !visible

func onSlotClicked(slot):
	pass
