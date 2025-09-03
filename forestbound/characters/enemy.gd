extends CharacterBody2D
class_name Enemy

@export var speed = 20
@export var limit = 0.5

@onready var animations = $AnimatedSprite2D
@onready var player = $"../CharacterBody2D"
@onready var health_bar = $health_bar
@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer

var max_health = 100
var health = 100
var player_in_range = false

var startPosition
var endPosition


func _ready():
	startPosition = position
	endPosition = startPosition + Vector2(3*16, 0)
	effects.play("RESET")


func _process(_delta) -> void:
	if player_in_range == true:
		if Input.is_action_just_pressed("use_item"):
			var attack_damage = Globle.attack_damage
			take_damage(attack_damage)


func take_damage(damage):
	effects.play("hurtBlink")
	health -= int(damage)
	health_bar.value = float(health) * 100 / max_health
	if health < 1:
		# play death animation
		queue_free()
		$FollowMovementC.disable()
	hurtTimer.start()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_range = true


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		player_in_range = false


func _on_hurt_timer_timeout() -> void:
		effects.play("RESET")
