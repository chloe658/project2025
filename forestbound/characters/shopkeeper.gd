extends CharacterBody2D

var player_near = false

func _on_player_near(_body: Node2D) -> void:
	player_near = true

func _on_player_exited(_body: Node2D) -> void:
	player_near = false

func _process(_delta):
	if player_near == true and Input.is_action_just_pressed("interact"):
		$"../CharacterBody2D/shopMenu".visible = true
