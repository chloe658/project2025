extends Area2D

var item_name
var item_quantity

func _ready():
	
	item_name = "Mooncap Mushroom"
	item_quantity = 1

func _on_body_entered(_body: Node2D) -> void:
	PlayerInventory.add_item(item_name, item_quantity)
	queue_free()
