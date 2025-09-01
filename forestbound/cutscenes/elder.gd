extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5

var startPosition
var endPosition

func _ready():
	var endPoint
	if get_parent().name == "closing_scene1":
		endPoint = Vector2(0, 0)
	if get_parent().name == "opening_scene1":
		endPoint = Vector2(0, 5*16)
	startPosition = position
	endPosition = startPosition + endPoint

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		position = endPosition
		moveDirection = Vector2(0, 0)
	velocity = moveDirection.normalized() * speed

func updateAnimation():
	var animationString = "idle"
	if velocity.y < 0:
		animationString = "walk_up"
	elif velocity.y > 0:
		animationString = "walk_down"
	$"AnimatedSprite2D".play(animationString)

func _process(_delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
