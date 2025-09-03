extends Node

var CoinCount = 1500
var maxHealth = 100
var currentHealth = 100
var attack_damage = 1
var held_item = ""
var transition
var hurting = false
var next_dialogue = false
#var held_item_changed = false

# Only spawn in quest items once
var collected_cinder_fern_spore = false
var collected_ghostmint_leaf = false
var collected_crystalfly_wing = false

# Quests
var explore_dungeon = false
var collector_quest_complete = false # "Collect Ingredients"
var traveler_quest_complete = false # "Find Secret"
var free_curse = false

var finished_first_cutscene = false

signal healthChanged
signal coinChanged


func take_damage():
	currentHealth -= 5
	hurting = true
	healthChanged.emit()
	hurting = false


func increase_health(amount):
	currentHealth += amount
	healthChanged.emit()

func earn_coins(amount):
	CoinCount += amount
	coinChanged.emit()


func spend_coins(amount):
	CoinCount -= amount
	coinChanged.emit()
