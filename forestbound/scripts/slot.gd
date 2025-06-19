extends Panel

var default_tex = preload("res://assets/UI/inventory_slot.png")
var empty_tex = preload("res://assets/UI/empty_slot.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://scenes/item.tscn")
var item = null
var slot_index

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	refresh_style()

func refresh_style():
	if item == null:
		set("custon_styles/panel", empty_style)
	else:
		set("custon_styles/panel", default_style)

func pick_from_slot():
	remove_child(item)
	var inventory_node = find_parent("inventory")
	inventory_node.add_child(item)
	item = null
	refresh_style()
	
func put_into_slot(new_item):
		#item = new_item
		if new_item.get_parent():
			new_item.get_parent().remove_child(new_item)
		item = new_item.duplicate(true)
		item.position = Vector2(0, 0)
		#var inventory_node = find_parent("inventory")
		#inventory_node.remove_child(item)
		if item.get_parent():
			item.get_parent().remove_child(item)
		add_child(item)
		refresh_style()

func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instantiate()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
	refresh_style()
