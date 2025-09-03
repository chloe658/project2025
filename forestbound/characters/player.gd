class_name Player extends CharacterBody2D

signal healthChanged

@export var maxHealth = 100
@export var knockbackPower: int = 50
@export var speed: int = 150
@export var inventory: Inventory

@onready var hurtbox = $Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var inventory_gui = $InventoryGui
@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer
@onready var dialogue_box = $dialogue_box
@onready var weapon = $weapon
@onready var lastAnimDirection: String = "Down"
@onready var animations = $AnimationPlayer
#@onready var held_item = $held_item
@onready var slots = $InventoryGui.slots

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isHurt: bool = false
var enemyCollisions = []
var isAttacking: bool = false


func _on_ready() -> void:
	healthChanged.emit()
	inventory.use_item.connect(use_item)
	effects.play("RESET")

func _physics_process(_delta):
	move_and_slide()
	handleInput()
	updateAnimation()
	#handleCollision()
	if !isHurt:
		for enemyArea in enemyCollisions:
			hurtByEnemy(enemyArea)

func handleInput():
	if Input.is_action_just_pressed("use_item"):
		var currently_holding = slots[Globle.hotbarIndex].itemStackGui.inventorySlot.item.name
		if currently_holding == "Sword":
			animations.play("attack" + lastAnimDirection)
			isAttacking = true
			weapon.visible = true
			await animations.animation_finished
			weapon.visible = false
			isAttacking = false
		else:
			print(currently_holding)
		
	if Input.is_action_just_pressed("escape"):
		if inventory_gui.visible == true:
			inventory_gui.visible = false
		if get_tree().current_scene.name == "house_interior":
			$shopMenu.visible = false


func updateAnimation():
	if isAttacking: return
	if inventory_gui.visible == false and dialogue_box.visible == false:
		if get_tree().current_scene.name == "house_interior":
			if $shopMenu.visible == true: return
		# Get the input direction and handle the movement/deceleration.
		var horizontal_direction = Input.get_axis("move_left", "move_right")
		var vertical_direction = Input.get_axis("move_up", "move_down")
		if vertical_direction == 0 and horizontal_direction == 0:
			animated_sprite_2d.play("idle")
			lastAnimDirection = "Down"

		else:
			if horizontal_direction > 0:
				animated_sprite_2d.play("walk_right")
				lastAnimDirection = "Right"
			elif horizontal_direction < 0:
				animated_sprite_2d.play("walk_left")
				lastAnimDirection = "Left"
			elif vertical_direction > 0:
				animated_sprite_2d.play("walk_down")
				lastAnimDirection = "Down"
			elif vertical_direction < 0:
				animated_sprite_2d.play("walk_up")
				lastAnimDirection = "Up"
		
		# Move player
		if horizontal_direction:
			velocity.x = horizontal_direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

		if vertical_direction:
			velocity.y = vertical_direction * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)
		
	"""
	else:
		get_tree().paused = true
		tutorial at ~10 minutes #1
	"""

"""
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
"""

func _on_area_2d_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
	
	if area.name == "hitbox":
		enemyCollisions.append(area)
		

func increase_health(amount):
	Globle.increase_health(amount)

func use_item(item: InventoryItem) -> void:
	if not item.can_be_used(self): return
	item.use(self)
	if item.consumamble:
		inventory.remove_last_used_item()

func attack_enemy(amount):
	Globle.attack_damage = amount

func die():
	#play death animation
	get_tree().change_scene_to_file("res://scenes/town.tscn")
	Globle.transition = get_parent().name
	Globle.currentHealth = Globle.maxHealth

func knockback(enemyVelocity):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func _on_area_2d_area_exited(area: Area2D) -> void:
	enemyCollisions.erase(area)


func hurtByEnemy(area):
	Globle.take_damage()
	if Globle.currentHealth <= 0:
		die()
	isHurt = true
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false


func _on_next_pressed() -> void:
	Globle.next_dialogue = true
