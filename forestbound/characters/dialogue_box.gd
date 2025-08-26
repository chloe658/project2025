extends NinePatchRect

@onready var label = $Label

var dialogues = {
	"traveler": [
	"Heh… You’ve got that curious look in your eyes. Want to know the secrets of this town, do ya? Well… secrets ain’t free. Slip me a few coins, and maybe I'll tell you...",
	"Hah! You actually paid up? Didn’t think you had the guts… or the coin. Truth is, I don’t know much worth telling. But… I did find this little oddity years ago, poking around some ruins. Strange thing, never seen its like again. Maybe it’ll be of use to you…",
	"Careful with it. Shines real pretty… but sometimes the prettiest lights hide the darkest paths.",
	"" #empty line to signal end of dialogue.
	],
	"wanderer": [
	"You… you’re really heading into the dungeon? Hah… I marched in once, fire in my veins, certain I’d carve my legend into those walls. But the shadows stripped it away, until I crawled out barely alive. Now, even the air out here chills my blood.",
	"If you return, may your spirit burn brighter than mine ever did. Someone ought to claim victory over that place… it just won’t be me.",
	"But mark me—gold weighs nothing if you don’t live to carry it out.",
	""
	]
}


var current_character = "wanderer"
var dialogue_index = 0


func _process(_delta) -> void:
	pass
	# only do if player is in range
	#if Input.is_action_just_pressed("interact"):
		#next_dialogue(current_character)

func show_dialogue(name):
	print(name)
	if name == "npc2":
		current_character = "wanderer"
	if name == "traveler":
		current_character = "traveler"
	var lines = dialogues[current_character]
	var line = lines[dialogue_index]
	
	if line == "":
		self.visible = false  # assuming your dialogue box node is called "Dialogue"
	else:
		self.visible = true
		label.text = current_character + ": " + line


func next_dialogue(name):
	dialogue_index += 1
	print("next dialogue")
	
	var lines = dialogues[current_character]
	if dialogue_index >= lines.size():
		dialogue_index = 0 # loop back, or remove this line if you want it to stop at the end
	
	show_dialogue(name)


#a thte moment only shows 1 I think this is because i dont update current character
