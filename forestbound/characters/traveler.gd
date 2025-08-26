extends AnimatedSprite2D


var player_near = false
@onready var player = $"../CharacterBody2D"
@onready var dialogue_box = $"../CharacterBody2D/dialogue_box"
@onready var label = $"../CharacterBody2D/dialogue_box/Label"
@onready var inventory: Inventory = preload("res://inventory folder/player_inventory.tres")

var index = 0

var dialogue_traveler = [
	"",
	"Traveler: Heh… You’ve got that curious look in your eyes. Want to know the secrets of this town, do ya?",
	"Traveler: Well… secrets ain’t free. Slip me a few coins, and maybe I'll tell you...",
	"Traveler: Hah! You actually paid up? Didn’t think you had the guts… or the coin. Truth is, I don’t know much worth telling.",
	"Traveler: I did find this little oddity years ago, poking around some ruins. Strange thing, never seen it’s like again. Maybe it’ll be of use to you…",
	"Traveler: Careful with it. Shines real pretty… but sometimes the prettiest lights hide the darkest paths."
]

var dialogue_wanderer = [
	"",
	"Wanderer: You… you’re really heading into the dungeon? Hah… I marched in once, fire in my veins, certain I’d carve my legend into those walls.",
	"Wanderer: But the shadows stripped it away, until I crawled out barely alive. Now, even the air out here chills my blood.",
	"Wanderer: If you return, may your spirit burn brighter than mine ever did. Someone ought to claim victory over that place… it just won’t be me.",
	"Wanderer: But mark me—gold weighs nothing if you don’t live to carry it out."
]


func on_player_near(body: Node2D) -> void:
	if body is Player:
		player_near = true


func on_player_exited(body: Node2D) -> void:
	if body is Player:
		player_near = false


func _process(_delta):
	if player_near == true and Input.is_action_just_pressed("interact"):
		change_text()
		if label.text != "":
			dialogue_box.visible = true
		else:
			dialogue_box.visible = false


func change_text():
	var character_name = self.name
	var current_character_dialogue = []
	if character_name == "npc2":
		current_character_dialogue = dialogue_traveler
	elif character_name == "wanderer":
		current_character_dialogue = dialogue_wanderer
	else:
		# So that game does not crash and problem can be found.
		print("Character name not found")
		print(character_name)
	if !Globle.traveler_quest_complete and character_name == "npc2":
		if index == 2:
			Globle.spend_coins(100)
		if index == 4:
			inventory.insert(load("res://inventory folder/items/willow_wisps.tres"))
			Globle.traveler_quest_complete = true
	
	index += 1
	if index > len(current_character_dialogue) - 1:
		index = 0
	label.text = current_character_dialogue[index]
