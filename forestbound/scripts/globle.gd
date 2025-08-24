extends Node

var CoinCount = 1500
var maxHealth = 100
var currentHealth = 100
var attack_damage = 1
signal healthChanged
signal coinChanged
var hurting = false

var transition

func take_damage():
	currentHealth -= 5
	hurting = true
	healthChanged.emit()
	hurting = false

func increase_health(amount):
	currentHealth += amount
	currentHealth = min(maxHealth, currentHealth)
	print(amount)
	print(currentHealth)
	healthChanged.emit()

func earn_coins(amount):
	CoinCount += amount
	coinChanged.emit()

func spend_coins(amount):
	CoinCount -= amount
	coinChanged.emit()
