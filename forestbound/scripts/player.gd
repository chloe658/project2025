extends CharacterBody2D


const SPEED = 150.0

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(_delta):

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
