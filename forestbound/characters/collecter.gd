extends AnimatedSprite2D


var player_near = false
@onready var player = $"../CharacterBody2D"
@onready var dialogue_box = $"../CharacterBody2D/dialogue_box"
@onready var label = $"../CharacterBody2D/dialogue_box/Label"
@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")
@onready var hotbar = $"../CharacterBody2D/hotbar"


var index = 0
var current_quest_complete = false
var quest_complete = false
var item_index = 0


var dialogue_collecter = [
	"Ah… a brave soul. You’d help me, wouldn’t you? I’ve been gathering what I need for a potion to change the town’s fate. Seek where the air runs cold and unseen whispers curl — a pale leaf shrouded in frost awaits. Bring it to me, and your task will continue.",
	"Ah, you have returned true to your promise. Now, seek the Cinder Fern spore, ember-born and hidden deep within ash and soil. Bring it to me, and the next step shall unfold.",
	"Well done, you returned with the Cinder Fern Spore. Now, seek a Crystalfly’s wing, shimmering like the morning sky. Bring it to me—this shall be the last piece, and all shall be revealed.",
	"At last… all the ingredients lie before me. I have waited countless years for this moment: the leaf of a Ghostmint, the spore of a Cinderfern, and the wing of a Crystalfly…",
	"…It seems… it did not awaken as I had hoped.",
	"Ah, how foolish of me—I neglected the final ingredient: a wisp. I suppose it belongs to you now.",
	"There is nothing more I require. Go on now, and let your curiosity wander elsewhere.",
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
	if player_near == true and Input.is_action_just_pressed("interact"):
		if index == 6:
			dialogue_box.visible = !dialogue_box.visible
			Globle.collector_quest_complete = true
		elif index > 3:
			dialogue_box.visible = true
			index += 1
		else:
			dialogue_box.visible = !dialogue_box.visible
			collect_item()
		label.text = dialogue_collecter[index]
			
			
	"""
		if !quest_complete:
			dialogue_box.visible = !dialogue_box.visible
			collect_item()
		if Globle.collector_quest_complete:
			dialogue_box.visible = !dialogue_box.visible
			update_index()
		if quest_complete:
			dialogue_box.visible = true
			update_index()
	
		

func update_index():
	if index > 6:
		index += 1
		label.text = dialogue_collecter[index]
	else:
		Globle.collector_quest_complete = true
"""

func collect_item():
	if Globle.held_item == items[item_index]:
		inventory.use_item_at_index(hotbar.currently_selected)
		current_quest_complete = true
		index += 1 
		if item_index < 2:
			item_index += 1
		else: 
			quest_complete = true
			inventory.insert(load("res://inventory folder/items/willow_wisps.tres"))
			index += 1
			print("quest complete")

"""

func update_index():
	
	if Globle.collector_quest_complete:
		#repeat first and last line if quest is complete
		if index == 0:
			index = 8
		if index == 8:
			index = 0
		return
	if index != 1 or index != 2 or index != 3 or current_quest_complete:
		print("conditions met")
		index += 1
		label.text = dialogue_collecter[index]
		if current_quest_complete:
			item_index += 1
		current_quest_complete = false
		
		if index == 8:
			Globle.collector_quest_complete = true
	print(Globle.collector_quest_complete)
"""
