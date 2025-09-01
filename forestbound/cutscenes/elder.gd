extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5

var startPosition
var endPosition

func _ready():
	var endPoint
	if name == "player":
		endPoint = Vector2(10*16, 0)
	if name == "elder":
		endPoint = Vector2(0, 5*16)
	startPosition = position
	endPosition = startPosition + endPoint #move 10 pixels to the right

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		position = endPosition
		moveDirection = Vector2(0, 0)
	velocity = moveDirection.normalized() * speed

func updateAnimation():
	var animationString = "idle"
	"""
	if velocity.x > 0:
		animationString = "walk_right"
	elif velocity.x < 0:
		animationString = "walk_left"
	"""
	if velocity.y < 0:
		animationString = "walk_up"
	elif velocity.y > 0:
		animationString = "walk_down"
	$"AnimatedSprite2D".play(animationString)

func _process(_delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
