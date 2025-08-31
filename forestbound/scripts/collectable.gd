extends Area2D

@export var itemRes: InventoryItem
@export var slots: Array[InventorySlot]
signal collected

func _process(_delta):
	if self.name == "cinder_fern_spore" and Globle.collected_cinder_fern_spore == true:
		queue_free()
	if self.name == "ghostmint_leaf" and Globle.collected_ghostmint_leaf == true:
		queue_free()
	if self.name == "crystalfly_wing" and Globle.collected_crystalfly_wing == true:
		queue_free()


func collect(inventory: Inventory):
	if self.name == "willow_wisps":
		emit_signal("collected")
	
	if self.name == "cinder_fern_spore":
		Globle.collected_cinder_fern_spore = true
	if self.name == "ghostmint_leaf":
		Globle.collected_ghostmint_leaf = true
	if self.name == "crystalfly_wing":
		Globle.collected_crystalfly_wing = true


	"""
	var emptySlots = slots.filter(func (s): return s.isEmpty)
	if emptySlots.is_empty(): return
	"""
	# TO DO: do not pick up items if inventory is full
	inventory.insert(itemRes)
	queue_free()
