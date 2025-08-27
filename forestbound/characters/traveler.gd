extends AnimatedSprite2D


var player_near = false
@onready var player = $"../CharacterBody2D"
@onready var dialogue_box = $"../CharacterBody2D/dialogue_box"
@onready var label = $"../CharacterBody2D/dialogue_box/Label"
@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")

var index = 0

var current_character_dialogue = []
@onready var character_name = self.name

var dialogue_traveler = [
	#"",
	"Traveler: Heh… You’ve got that curious look in your eyes. Want to know the secrets of this town, do ya?",
	"Traveler: Well… secrets ain’t free. Slip me a few coins, and maybe I'll tell you...",
	"Traveler: Hah! You actually paid up? Didn’t think you had the guts… or the coin. Truth is, I don’t know much worth telling.",
	"Traveler: I did find this little oddity years ago, poking around some ruins. Strange thing, never seen it’s like again. Maybe it’ll be of use to you…",
	"Traveler: Careful with it. Shines real pretty… but sometimes the prettiest lights hide the darkest paths.",
	""
]

var dialogue_wanderer = [
	#"",
	"Wanderer: You… you’re really heading into the dungeon? Hah… I marched in once, fire in my veins, certain I’d carve my legend into those walls.",
	"Wanderer: But the shadows stripped it away, until I crawled out barely alive. Now, even the air out here chills my blood.",
	"Wanderer: If you return, may your spirit burn brighter than mine ever did. Someone ought to claim victory over that place… it just won’t be me.",
	"Wanderer: But mark me—gold weighs nothing if you don’t live to carry it out.",
	""
]


func on_player_near(body: Node2D) -> void:
	if body is Player:
		player_near = true


func on_player_exited(body: Node2D) -> void:
	if body is Player:
		player_near = false


func _process(_delta):
	if player_near == true and Input.is_action_just_pressed("interact"): #controls visability
		if dialogue_box.visible == false:
			index = 0 #when first opening the box, set index to 0
		dialogue_box.visible = true
		get_current_character()
		label.text = current_character_dialogue[index]
		if Globle.traveler_quest_complete:
			index = 0 #when opening for the second time the index will be the last dialogue
			label.text = current_character_dialogue[index]
	if player_near == true and Globle.next_dialogue == true:
		change_text()
		Globle.next_dialogue = false
		if label.text == "":
			dialogue_box.visible = false
			#index = 0
		else:
			dialogue_box.visible = true

func get_current_character():
	if character_name == "traveler":
		current_character_dialogue = dialogue_traveler
	elif character_name == "wanderer":
		current_character_dialogue = dialogue_wanderer
	else:
		# So that game does not crash and problem can be found.
		print("Character name not found")
		print(character_name)

func change_text():
	get_current_character()
	if !Globle.traveler_quest_complete and character_name == "traveler":
		if index == 1:
			Globle.spend_coins(100)
		if index == 3:
			# this part of the code nver runs
			inventory.insert(load("res://inventory folder/items/willow_wisps.tres"))
			print(index)
			Globle.traveler_quest_complete = true
			print("traveler_quest_complete")
	
	if index < len(current_character_dialogue) - 1:
		index += 1
	else: 
		dialogue_box.visible = false
		index = 0
	label.text = current_character_dialogue[index]
