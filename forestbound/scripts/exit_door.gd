extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		$Timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/town.tscn")
