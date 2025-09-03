extends Node2D

@onready var player = $player
@onready var elder = $elder
@onready var dialogue_box = $dialogue_box
@onready var label = $dialogue_box/Label

var trigger_dialogue = false
var dialogue_complete = false
var index = 0


var dialogue_elder = [
	"Who goes there? ...Ah—wait. It's you.",
	"We’ve been expecting you.",
	"For a moment, I thought you were… someone else. Like the last time.",
	"Those poor souls still linger in the wisps. Be glad you are not among them… yet.",
	"Ill take you to the village.",
	""
	]
var dialogue_ending = [
	"The End.",
	""
]

func change_text():
	#if get_tree().current_scene.name == "opening_scene1":
	if index < len(dialogue_elder) - 2:
		index += 1
		label.text = dialogue_elder[index]
	else:
		trigger_dialogue = false
		dialogue_complete = true
		dialogue_box.visible = false
		$Efffects.play("fade")
		$Timer.start()
	"""
	if get_tree().current_scene.name == "closing_scene1":
		if index < len(dialogue_ending) - 2:
			index += 1
			label.text = dialogue_ending[index]
		else:
			trigger_dialogue = false
			dialogue_complete = true
			dialogue_box.visible = false
			$Efffects.play("fade")
			$Timer.start()
	"""


func _on_texture_button_pressed() -> void:
	change_text()


func _process(_delta):
	if trigger_dialogue == true:
		dialogue_box.visible = true


func _on_timer_timeout() -> void:
	change_scene()


func _on_skip_btn_pressed() -> void:
	print("skip")
	change_scene()

func change_scene():
	if get_tree().current_scene.name == "opening_scene1":
		Globle.finished_first_cutscene = true
	get_tree().change_scene_to_file("res://scenes/town.tscn")
