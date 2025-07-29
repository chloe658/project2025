extends CharacterBody2D

@onready var hotbar = $"../CharacterBody2D/hotbar"
@onready var health = 100
@onready var held_item = $"../CharacterBody2D/held_item"

var attack_damage: int
var player_in_range = false

func take_damage(damage):
	health -= damage
	if health < 1:
		# play death animation
		queue_free()


func _process(_delta) -> void:
	if player_in_range == true:
		if Input.is_action_just_pressed("use_item"):
			if held_item.texture.resource_path == "res://assets/Items/Sword.png":
				attack_damage = 10
				# if the player is holding sword deal 10 damage
				# change this to the attack damage property of item
			else:
				attack_damage = 5
			take_damage(attack_damage)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		player_in_range = true


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		player_in_range = false
