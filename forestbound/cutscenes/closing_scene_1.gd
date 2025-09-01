extends Node2D

@onready var wisp_jar = $wisps_jar
@onready var wisps = $wisps
@onready var effects = $Efffects

func _ready():
	wisp_jar.play("release_wisps")
	$jar_timer.start()


func _on_jar_timer_timeout() -> void:
	$wisps_jar/PointLight2D.queue_free()
	wisps.visible = true
	$pause_timer.start()


func _on_pause_timer_timeout() -> void:
	$Efffects.play("fade")
	$effects_timer.start()


func _on_effects_timer_timeout() -> void:
	print("scene changed")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
