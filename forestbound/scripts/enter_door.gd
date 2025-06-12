extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		$open_door.visible = true
		$Timer.start()

func _on_tree_exited() -> void:
	$open_door.visible = false

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/house_interior.tscn")
