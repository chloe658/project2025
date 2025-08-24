class_name FollowMovementC extends Node

#https://www.youtube.com/watch?v=kNFd6-CfQjo 15:30 tutorial

#enemyn will get stuck on walls.
# 1. when following the player, after a time limit or not being in the players area it will return
# 2. if the enemny is not on the players screen, teleport it back to the start position.
# 3. if enemn is out of sight but start posotion isnt, using visibility notifier to only tp when not visible.
# 4. pathfinding with markers (advanced)

@export var speed = 20
@export var overshoot_limit: int = 2

@onready var parent: CharacterBody2D = get_parent()
var start_position
var target: Player

func _ready():
	start_position = parent.position

func update_velocity():
	if !target:
		var dir_to_start = start_position - parent.global_position
		if dir_to_start.length() < overshoot_limit:
			parent.global_position = start_position
			$"../AnimatedSprite2D".play("idle")
			return
		parent.velocity = dir_to_start.normalized() * speed
		return
		
	var direction = target.global_position - parent.global_position
	var new_velocity = direction.normalized() * speed
	parent.velocity = new_velocity

func _physics_process(delta) -> void:
	update_velocity()
	parent.move_and_slide()
	updateAnimation()

func updateAnimation():
	var animationString = "idle"
	if parent.velocity.x > 0:
		animationString = "walk_right"
	elif parent.velocity.x < 0:
		animationString = "walk_left"
	elif parent.velocity.y > 0:
		animationString = "walk_up"
	elif parent.velocity.y < 0:
		animationString = "walk_down"
	
	$"../AnimatedSprite2D".play(animationString)


func disable() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED


func _on_follow_area_body_entered(body: Node2D) -> void:
	# follow player if they are in range
	if body is Player:
		target = body


func _on_follow_area_body_exited(body: Node2D) -> void:
	# stop follwing player if they are out of range
	if body == target:
		target = null
