extends Button

@onready var background_sprite: Sprite2D = $background
@onready var item_stack_gui: ItemStackGui = $CenterContainer/Panel
@onready var hotbar = $"../../.."


@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")
@onready var slots: Array = $"..".get_children()

func update_to_slot(slot: InventorySlot) -> void:
	if !slot.item:
		item_stack_gui.visible = false
		return
	item_stack_gui.inventorySlot = slot
	item_stack_gui.update()
	item_stack_gui.visible = true 
	

func get_held_slot(_slot: InventorySlot) -> void:
	var held_item_slot: InventorySlot = inventory.slots[hotbar.currently_selected]
	if held_item_slot.item:
		Globle.held_item = held_item_slot.item.name
	else:
		Globle.held_item = ""
