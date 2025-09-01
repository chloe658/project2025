extends AnimatedSprite2D


var player_near = false
@onready var player = $"../CharacterBody2D"
@onready var dialogue_box = $"../CharacterBody2D/dialogue_box"
@onready var label = $"../CharacterBody2D/dialogue_box/Label"
@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")

var index = 0
const BRIBE = 1000
var paid_traveler = false
var final_dialogue_bool = false

var current_character_dialogue = []
@onready var character_name = self.name


var dialogue_traveler = [
	"Traveler: Heh… You’ve got that curious look in your eyes. Want to know the secrets of this town, do ya?",
	"Traveler: Well… secrets ain’t free. Slip me a few coins, and maybe I'll tell you...",
	"Traveler: Hah! You actually paid up? Didn’t think you had the guts… or the coin. Truth is, I don’t know much worth telling.",
	"Traveler: I did find this little oddity years ago, poking around some ruins. Strange thing, never seen it’s like again. Maybe it’ll be of use to you…",
	"Traveler: Careful with it. Shines real pretty… but sometimes the prettiest lights hide the darkest paths.",
	""
]

var traveler_quest_dialogue = [
	"Bring coin, then we’ll talk.",
	"empty",
]

var traveler_complete_dialogue = [
	"Traveler: Heh, don’t look at me like that. I already gave you more than you deserved—now get lost.",
	"empty"
]

var dialogue_wanderer = [
	"Wanderer: You… you’re really heading into the dungeon? Hah… I marched in once, fire in my veins, certain I’d carve my legend into those walls.",
	"Wanderer: But the shadows stripped it away, until I crawled out barely alive. Now, even the air out here chills my blood.",
	"Wanderer: If you return, may your spirit burn brighter than mine ever did. Someone ought to claim victory over that place… it just won’t be me.",
	"Wanderer: But mark me—gold weighs nothing if you don’t live to carry it out.",
	""
]
var dialogue_elder = [
	"Elder: This town is old… older than the stones beneath our feet. Whispers cling to its corners, hidden truths waiting for brave ears.",
	"Elder: The villagers guard their truths like locked chests. Some with shame, others with fear.",
	"Elder: Go. Speak with them. Piece them together, and you will find the secret that binds this place.",
	""
]

var final_dialogue = [
	"bye",
]


func on_player_near(body: Node2D) -> void:
	if body is Player:
		player_near = true


func on_player_exited(body: Node2D) -> void:
	if body is Player:
		player_near = false


func _process(_delta):
	self.play("idle")
	if player_near == true and Input.is_action_just_pressed("interact"): #controls visability
		if dialogue_box.visible == false:
			index = 0 #when first opening the box, set index to 0
		dialogue_box.visible = true
		get_current_character()
		label.text = current_character_dialogue[index]
		if Globle.traveler_quest_complete:
			index = 0 #when opening for the second time the index will be the last dialogue so now it will be the first
			label.text = current_character_dialogue[index]
	if player_near == true and Globle.next_dialogue == true:
		get_current_character()
		if character_name == "traveler":
			change_text_traveler()
		else:
			change_text_other()
		Globle.next_dialogue = false
		if label.text == "":
			# or label.text == "empty":
			# if at end of dialogue, make dialogue box invisible
			dialogue_box.visible = false
		else:
			dialogue_box.visible = true

func get_current_character():
	if character_name == "traveler":
		current_character_dialogue = dialogue_traveler
	elif character_name == "wanderer":
		current_character_dialogue = dialogue_wanderer
	elif character_name == "elder":
		if Globle.explore_dungeon == false or Globle.collector_quest_complete == false or Globle.traveler_quest_complete == false:
			current_character_dialogue = dialogue_elder
		else:
			current_character_dialogue = final_dialogue
			final_dialogue_bool = true

func change_text_traveler():
	if !Globle.traveler_quest_complete:
		# only take coins and give item if the player has not completed the quest before
		if index == 1:
			if Globle.CoinCount >= BRIBE:
				Globle.spend_coins(BRIBE)
				paid_traveler = true
			else: 
				if label.text != traveler_quest_dialogue[0]:
					label.text = traveler_quest_dialogue[0]
				else: label.text = traveler_quest_dialogue[1]
				return
				
		if index == 3 and paid_traveler:
			inventory.insert(load("res://inventory folder/items/willow_wisps.tres"))
			Globle.traveler_quest_complete = true
	if index < len(current_character_dialogue) - 1:
		index += 1
	else:
		dialogue_box.visible = false
		index = 0
	if Globle.traveler_quest_complete:
		pass

	label.text = current_character_dialogue[index]
	
func change_text_other():
	if index < len(current_character_dialogue) - 1:
		index += 1
	else:
		if !final_dialogue:
			dialogue_box.visible = false
			index = 0
		else:
			get_tree().change_scene_to_file("res://cutscenes/closing_scene_1.tscn")
	label.text = current_character_dialogue[index]
