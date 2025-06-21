extends Resource

class_name InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var maxAmountPrStack: int = 5

func use(_player: Player) -> void:
	pass
	# each item works differently.
	# use tutorial: https://www.youtube.com/watch?v=HzkRw1Sc1Dg&list=PLMQtM2GgbPEW__dODFVRPNF2TBry25IK4&index=11 at 16:50
