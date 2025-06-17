extends Area2D

var item_name

func _ready():
	
	item_name = "Mooncap Mushroom"

func _on_body_entered(_body: Node2D) -> void:
	PlayerInventory.add_item(item_name, 1)
	queue_free()
