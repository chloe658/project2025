extends Node2D

@onready var player = $CharacterBody2D
@onready var dungeon_respawn = $dungeon_respawn
@onready var house_respawn = $house_respawn

@export var min_respawn_time: float = 5.0
@export var max_respawn_time: float = 15.0
@onready var timer = $collectable_timer

@onready var collectables: Array = $collectables.get_children()


func _on_tree_entered() -> void:
	await get_tree().process_frame
	if Global.transition == "dungeon_room":
		player.global_position = dungeon_respawn.global_position
	
	if Global.transition == "house_interior":
		player.global_position = house_respawn.global_position


func _ready():
	randomize()
	timer.one_shot = true
	timer.start(randf_range(min_respawn_time, max_respawn_time))


func _on_collectable_timer_timeout() -> void:
	collectables = $collectables.get_children() #get new list each time
	if collectables.size() > 0:
		var random_index = randi() % collectables.size()
		var chosen_item = collectables[random_index]
		chosen_item.visible = true
	timer.start(randf_range(min_respawn_time, max_respawn_time))
