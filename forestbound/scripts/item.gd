class_name ItemClass
extends Node2D

var item_name
var item_quantity

func _ready():
	# this is the part that is causing an error because it changes the items to mushrooms
	item_name = "Ghostmint Leaf"
	item_quantity = 3


	$TextureRect.texture = load("res://assets/Items/" + item_name + ".png")
	var stack_size = int(JSONdata.item_data[item_name]["StackSize"])
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = str(item_quantity)
	
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = str(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = str(item_quantity)

func set_item(item_name, item_quantity):
	$TextureRect.texture = load("res://assets/Items/" + item_name + ".png")
	
	var stack_size = int(JSONdata.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = str(item_quantity)
