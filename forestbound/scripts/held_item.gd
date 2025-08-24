extends Sprite2D

@onready var hotbar = $"../hotbar"

func on_ready():
	var slots = hotbar.slots
	for slot in slots:
		print(slot.get_child("Panel").get_child("item"))

func update():
	# atm does not update when player moves / uses an item
	print("updated")
	var index = hotbar.currently_selected
	var slot = hotbar.slots[index]
	var held_item_texture = slot.get_node("CenterContainer/Panel/item").texture
	texture = held_item_texture
