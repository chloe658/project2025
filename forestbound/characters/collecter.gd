extends AnimatedSprite2D


var player_near = false
@onready var player = $"../CharacterBody2D"
@onready var dialogue_box = $"../CharacterBody2D/dialogue_box"
@onready var label = $"../CharacterBody2D/dialogue_box/Label"

var index = 0

var dialogue_collecter = [
	"",
	"Ah… a brave soul. You’d help me, wouldn’t you? I’ve been gathering what I need for a potion — one that might change the town’s fate — yet a few ingredients still slip through my grasp…",
	"Seek where shadows linger and daylight fades, a violet cap rests low to the earth. Bring it to me, and your task will continue.",
	"Ah, you have returned true to your promise. Now, seek the Oakshade sapling, its young shoots cloaked in shadow. Bring it to me, and the next step shall unfold.",
	"Well done, you return with the Oakshade. Now, seek a Crystalfly’s wing, shimmering like the morning sky. Bring it to me—this shall be the last piece, and all shall be revealed.",
	"At last… all the ingredients lie before me. I have waited countless years for this moment: the seed of an Oakshade, the stem of a Mooncap, and the wing of a Crystalfly…",
	"…It seems… it did not awaken as I had hoped.",
	"Ah, how foolish of me—I neglected the final ingredient: a wisp. I suppose it belongs to you now.",
	"There is nothing more I require. Go on now, and let your curiosity wander elsewhere.",
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
	if Globle.collector_quest_complete:
		if index == 0:
			index = 1
		if index == 1:
			index = 0
		return
	
	index += 1
	label.text = dialogue_collecter[index]
