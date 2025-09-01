extends Sprite2D

@onready var hotbar = $"../hotbar"
var held_item_texture

func update(index):
	"""
	if Globle.held_item != "Sword":
		visible = false
	else:
		visible = true
	"""
	#update happens one index behind
	var slot = hotbar.slots[index]
	held_item_texture = slot.get_node("CenterContainer/Panel/item").texture
	texture = held_item_texture
	
