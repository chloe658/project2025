extends Sprite2D

@onready var hotbar = $"../hotbar"
var held_item_texture
#var index = hotbar.currently_selected

func on_ready():
	var slots = hotbar.slots
	for slot in slots:
		pass
		#print(slot.get_child("Panel").get_child("item"))
		#print(slot.item.name)

func update(index):
	# atm does not update uses or moves an item
	#print("updated")
	print(Globle.held_item)
	var slot = hotbar.slots[index]
	held_item_texture = slot.get_node("CenterContainer/Panel/item").texture
	texture = held_item_texture
	
