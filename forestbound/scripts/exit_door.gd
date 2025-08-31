extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		Globle.transition = get_parent().name
		call_deferred("change_scene")

func change_scene():
	# in separate unctio so previous frame can finish and dont get an error about removing an object during callback
	get_tree().change_scene_to_file("res://scenes/town.tscn")
