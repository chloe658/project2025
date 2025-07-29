extends Node2D

var total_coins = Globle.CoinCount


func earn_coins(amount):
	total_coins = total_coins + amount
	update_label()


func spend_coins(amount):
	total_coins = total_coins - amount
	update_label()


func update_label():
	print(total_coins)
	$Label.text = str(total_coins)
