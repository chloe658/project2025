extends Node

var CoinCount = 1500
var currentHealth = 100
signal healthChanged
signal coinChanged
var hurting = false

func take_damage():
	#print("taking damage")
	currentHealth -= 5
	#print(currentHealth)
	hurting = true
	healthChanged.emit()
	hurting = false

func earn_coins(amount):
	CoinCount += amount
	coinChanged.emit()

func spend_coins(amount):
	CoinCount -= amount
	coinChanged.emit()
