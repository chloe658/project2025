extends Control

func _on_play_button_pressed() -> void:
	if Global.finished_first_cutscene == false:
		get_tree().change_scene_to_file("res://cutscenes/opening_scene_1.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/town.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
