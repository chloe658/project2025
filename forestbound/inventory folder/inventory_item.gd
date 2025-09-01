extends Resource

class_name InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var maxAmountPrStack: int = 13

func use(_player: Player) -> void:
	pass
	

func can_be_used(_player: Player):
	return true
