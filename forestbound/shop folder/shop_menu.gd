extends NinePatchRect

@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")
var item
var price

@onready var mooncap_mushroom = preload("res://inventory folder/items/mooncap_mushroom.tres")
@onready var lavender_bloom = preload("res://inventory folder/items/lavender_bloom.tres")
@onready var oakshade_sap = preload("res://inventory folder/items/oakshade_seed.tres")
@onready var batberry = preload("res://inventory folder/items/batberry.tres")


func _on_button_1_pressed() -> void:
	price = 15
	item = mooncap_mushroom
	buy_item(item, price)


func _on_button_2_pressed() -> void:
	price = 20
	item = lavender_bloom
	buy_item(item, price)


func _on_button_3_pressed() -> void:
	price = 25
	item = oakshade_sap
	buy_item(item, price)


func _on_button_4_pressed() -> void:
	price = 30
	item = batberry
	buy_item(item, price)


func buy_item(selected_item, item_price):
	if Globle.CoinCount >= item_price:
		inventory.insert(selected_item)
		Globle.spend_coins(item_price)

func _on_quit_button_pressed() -> void:
	visible = false
