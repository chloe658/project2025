extends Node2D

@onready var player = $CharacterBody2D
@onready var dungeon_respawn = $dungeon_respawn
@onready var house_respawn = $house_respawn

func _on_tree_entered() -> void:
	await get_tree().process_frame
	if Globle.transition == "dungeon_room":
		player.global_position = dungeon_respawn.global_position
	
	if Globle.transition == "house_interior":
		player.global_position = house_respawn.global_position
