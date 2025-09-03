extends Control

@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")
@onready var ItemStackGuiClass = preload("res://inventory folder/itemStackGui.tscn")
@onready var hotbar_slots: Array = $NinePatchRect/HBoxContainer.get_children()
@onready var slots: Array = hotbar_slots + $NinePatchRect/GridContainer.get_children()
@onready var inv_btn = $HBoxContainer/inventory_button/TextureRect
@onready var quest_btn = $HBoxContainer/quest_button/TextureRect
@onready var quit_btn = $HBoxContainer/quit_button/TextureRect
@onready var options_btn = $HBoxContainer/options_button/TextureRect
@onready var player: Player = $".."

var itemInHand: ItemStackGui
var oldIndex: int = -1

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()

func _process(_delta):
	update_buttons()

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
		
		if !inventorySlot.item:
			slots[i].clear()
			continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()

		if Globle.free_curse == true:
			if itemStackGui.inventorySlot.item.name == "Willow Wisps":
				inventory.removeSlot(slots[i].itemStackGui.inventorySlot)

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
	
	oldIndex = slot.index


func insertItemInSlot(slot):
	var item = itemInHand
	remove_child(item)
	itemInHand = null
	slot.insert(item)
	
	oldIndex = -1


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
		oldIndex = -1

	else: # if holding greater than allowed to add, add some, holder rest
		slotItem.inventorySlot.amount = maxAmount
		itemInHand.inventorySlot.amount = totalAmount - maxAmount
	
	slotItem.update()
	if itemInHand: itemInHand.update()


func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2


func putItemBack():
	if oldIndex > 0:
		var emptySlots = slots.filter(func (s): return s.isEmpty)
		if emptySlots.is_empty(): return
		oldIndex = emptySlots[0].index
	
	var targetSlot = slots[oldIndex]
	insertItemInSlot(targetSlot)


func _input(event):
	updateItemInHand()
	if event.is_action_pressed("toggle_inventory"):
		if itemInHand:
			putItemBack()
		player.velocity = Vector2(0, 0)
		if get_tree().current_scene.name == "house_interior":
			if $"../shopMenu".visible == true: return
			else: visible = !visible
		else: visible = !visible


func _on_inventory_button_pressed() -> void:
	inv_btn.texture = load("res://assets/UI/selected_tab.png")
	quest_btn.texture = load("res://assets/UI/tab.png")
	options_btn.texture = load("res://assets/UI/tab.png")
	$NinePatchRect.visible = true
	$NinePatchRect_Quest.visible = false
	$NinePatchRect_Options.visible = false


func _on_quest_button_pressed() -> void:
	inv_btn.texture = load("res://assets/UI/tab.png")
	quest_btn.texture = load("res://assets/UI/selected_tab.png")
	options_btn.texture = load("res://assets/UI/tab.png")
	$NinePatchRect.visible = false
	$NinePatchRect_Quest.visible = true
	$NinePatchRect_Options.visible = false


func _on_option_button_pressed() -> void:
	inv_btn.texture = load("res://assets/UI/tab.png")
	quest_btn.texture = load("res://assets/UI/tab.png")
	options_btn.texture = load("res://assets/UI/selected_tab.png")
	$NinePatchRect.visible = false
	$NinePatchRect_Quest.visible = false
	$NinePatchRect_Options.visible = true


func _on_quit_button_pressed() -> void:
	visible = false


func update_buttons():
	if Globle.explore_dungeon:
		$NinePatchRect_Quest/ScrollContainer/VBoxContainer/explore_dungeon/TickIcon.visible = true
	if Globle.collector_quest_complete: # "Collect Ingredients"
		$NinePatchRect_Quest/ScrollContainer/VBoxContainer/collect_ingredients/TickIcon.visible = true
	if Globle.traveler_quest_complete: # "Find Secret"
		$NinePatchRect_Quest/ScrollContainer/VBoxContainer/find_secret/TickIcon.visible = true
	if Globle.free_curse:
		$NinePatchRect_Quest/ScrollContainer/VBoxContainer/free_curse/TickIcon.visible = true


func _on_exit_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
