extends Node2D

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		item_name = "Sword"
	elif rand_val == 1:
		item_name = "Pickaxe"
	else:
		item_name = "Mooncap Mushroom"
	
	$TextureRect.texture = load("res://assets/Items/" + item_name + ".png")
	var stack_size = int(JSONdata.item_data[item_name]["StackSize"])
	item_quantity = 1
	#item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = str(item_quantity)
	
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = str(item_quantity)
	print(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = str(item_quantity)
	print(item_quantity)

func set_item(item_name, item_quantity):
	$TextureRect.texture = load("res://assets/Items/" + item_name + ".png")
	
	var stack_size = int(JSONdata.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = str(item_quantity)
		print(item_quantity)
