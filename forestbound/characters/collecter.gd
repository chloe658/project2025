extends AnimatedSprite2D

var player_near = false
@onready var player = $"../CharacterBody2D"
@onready var dialogue_box = $"../CharacterBody2D/dialogue_box"
@onready var label = $"../CharacterBody2D/dialogue_box/Label"
@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")
@onready var hotbar = $"../CharacterBody2D/hotbar"
@onready var InventoryGui = $"../CharacterBody2D/InventoryGui"

var index = 0
var quest_complete = false
var current_quest_complete = false
var item_index = 0

var dialogue_collecter = [
	"Collector: Ah… a brave soul. You’ll help me, won’t you? I need a potion to change the town’s fate. Seek where the air runs cold and whispers curl — a pale leaf in frost awaits. Bring it to me, and your quest will continue.",
	"Collector: Ah, you have returned true to your promise. Now, seek the Cinder Fern spore, ember-born and hidden deep within ash and soil. Bring it to me, and the next step shall unfold.",
	"Collector: Well done, you returned with the Cinder Fern Spore. Now, seek a Crystalfly’s wing, shimmering like the morning sky. Bring it to me—this shall be the last piece, and all shall be revealed.",
	"Collector: At last… all the ingredients lie before me. I have waited countless years for this moment: the leaf of a Ghostmint, the spore of a Cinderfern, and the wing of a Crystalfly…",
	"Collector: …It seems… it did not awaken as I had hoped.",
	"Collector: Ah, how foolish of me—I neglected the final ingredient: a wisp. I suppose it belongs to you now.",
	"Collector: There is nothing more I require. Go on now, and let your curiosity wander elsewhere.",
]

var items = [
	"Ghostmint Leaf",
	"Cinder Fern Spore",
	"Crystalfly Wing"
]


func on_player_near(body: Node2D) -> void:
	if body is Player:
		player_near = true


func on_player_exited(body: Node2D) -> void:
	if body is Player:
		player_near = false


func _process(_delta):
	self.play("idle")
	if Global.next_dialogue == true and player_near:
		# Controls index
		Global.next_dialogue = false
		if index == 5 and !Global.collector_quest_complete:
			inventory.insert(load("res://inventory folder/items/willow_wisps.tres"))
			Global.collector_quest_complete = true
		if index == len(dialogue_collecter) - 1:
			dialogue_box.visible = false
		if index > 2 and index < 6:
			index += 1
			label.text = dialogue_collecter[index]
		if index <= 2:
			collect_item()
		label.text = dialogue_collecter[index]
	if player_near and Input.is_action_just_pressed("interact"):
		# Controls visability
		if index == 7:
			dialogue_box.visible = !dialogue_box.visible
		else:
			dialogue_box.visible = true
		label.text = dialogue_collecter[index]


func collect_item():
	if Global.held_item == items[item_index]:
		current_quest_complete = true
		InventoryGui.remove_all_instances_of_item(items[item_index])
		inventory.use_item_at_index(hotbar.currently_selected)
		index += 1 
		if item_index < 2:
			item_index += 1
			return
		quest_complete = true
	else:
		current_quest_complete = false
		dialogue_box.visible = false
