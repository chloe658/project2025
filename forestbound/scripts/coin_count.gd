extends NinePatchRect

@onready var coin_label: Label = $Label
var total_coins: int = 1500
"""
func _ready():
	update_label()
"""
func earn_coins(amount):
	total_coins += amount
	update_label()

func spend_coins(amount):
	total_coins -= amount
	update_label()

func update_label():
	print(total_coins)
	#coin_label.text = str(total_coins)
