extends CharacterBody2D

class_name Player

signal healthChanged

@export var maxHealth = 100
#@onready var currentHealth: int = maxHealth
@onready var total_coins: int = 1500

const SPEED = 150.0

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var hurtbox = $Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var inventory_gui = $InventoryGui
@onready var hurting_cooldown = $Timer

@export var inventory: Inventory

var hurting = false

func _on_ready() -> void:
	healthChanged.emit()

func _physics_process(_delta):
	if !hurting:
		for area in hurtbox.get_overlapping_areas():
			if area.name == "hitbox":
				Globle.take_damage()
				hurting = false

	if inventory_gui.visible == false:
		# Get the input direction and handle the movement/deceleration.
		var horizontal_direction = Input.get_axis("move_left", "move_right")
		var vertical_direction = Input.get_axis("move_up", "move_down")
		
		# Play aminations
		if vertical_direction == 0 and horizontal_direction == 0:
			animated_sprite_2d.play("idle")
		else:
			if horizontal_direction > 0:
				animated_sprite_2d.play("walk_right")
			elif horizontal_direction < 0:
				animated_sprite_2d.play("walk_left")
			elif vertical_direction > 0:
				animated_sprite_2d.play("walk_down")
			elif vertical_direction < 0:
				animated_sprite_2d.play("walk_up")
		
		# Move player
		if horizontal_direction:
			velocity.x = horizontal_direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		if vertical_direction:
			velocity.y = vertical_direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
		move_and_slide()
	"""
	else:
		get_tree().paused = true
		tutorial at ~10 minutes #1
	"""


func _on_area_2d_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
		
"""
func take_damage():
	Globle.Health -= 5
	print(Globle.Health)
	hurting = true
	healthChanged.emit()
	
	hurting_cooldown.start()
	await hurting_cooldown.timeout
	hurting = false
"""
