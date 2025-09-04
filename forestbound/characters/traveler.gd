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
	"Traveler: Bring coin, then we’ll talk.",
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
	"At last… all the wisps are collected. They — I mean, the curse — can finally be freed. Come with me I have something to show you...",
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
		if Global.traveler_quest_complete:
			index = 0 #when opening for the second time the index will be the last dialogue so now it will be the first
			label.text = current_character_dialogue[index]
	if player_near == true and Global.next_dialogue == true:
		get_current_character()
		if character_name == "traveler":
			change_text_traveler()
		else:
			change_text_other()
		Global.next_dialogue = false
		if label.text == "": # if at end of dialogue, make dialogue box invisible
			dialogue_box.visible = false
		else:
			dialogue_box.visible = true


func get_current_character():
	if character_name == "traveler":
		current_character_dialogue = dialogue_traveler
	elif character_name == "wanderer":
		current_character_dialogue = dialogue_wanderer
	elif character_name == "elder":
		if Global.explore_dungeon == false or Global.collector_quest_complete == false or Global.traveler_quest_complete == false or Global.finished_last_cutscene == true:
			current_character_dialogue = dialogue_elder
		else:
			current_character_dialogue = final_dialogue
			final_dialogue_bool = true


func change_text_traveler():
	if !Global.traveler_quest_complete:
		# only take coins and give item if the player has not completed the quest before
		if index == 1:
			if Global.CoinCount >= BRIBE:
				Global.spend_coins(BRIBE)
				paid_traveler = true
			else: 
				if label.text != traveler_quest_dialogue[0]:
					label.text = traveler_quest_dialogue[0]
				else: label.text = traveler_quest_dialogue[1]
				return
				
		if index == 3 and paid_traveler:
			inventory.insert(load("res://inventory folder/items/willow_wisps.tres"))
			Global.traveler_quest_complete = true
	if index < len(current_character_dialogue) - 1:
		index += 1
	else:
		dialogue_box.visible = false
		index = 0
	if Global.traveler_quest_complete:
		# Add dialogue for when quest is complete.
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
			Global.free_curse = true
			get_tree().change_scene_to_file("res://cutscenes/closing_scene_1.tscn")
	label.text = current_character_dialogue[index]
