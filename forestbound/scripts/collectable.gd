extends Area2D

@export var itemRes: InventoryItem
@export var slots: Array[InventorySlot]
signal collected


func _process(_delta):
	if self.name == "cinder_fern_spore" and Global.collected_cinder_fern_spore == true:
		queue_free()
	if self.name == "ghostmint_leaf" and Global.collected_ghostmint_leaf == true:
		queue_free()
	if self.name == "crystalfly_wing" and Global.collected_crystalfly_wing == true:
		queue_free()


func collect(inventory: Inventory):
	if !visible: return
	if self.name == "willow_wisps":
		emit_signal("collected")
	
	if self.name == "cinder_fern_spore":
		Global.collected_cinder_fern_spore = true
	if self.name == "ghostmint_leaf":
		Global.collected_ghostmint_leaf = true
	if self.name == "crystalfly_wing":
		Global.collected_crystalfly_wing = true

	inventory.insert(itemRes)
	queue_free()
