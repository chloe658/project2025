extends Node2D


func _ready():
	if Globle.explore_dungeon == false:
		var wisps = preload("res://scenes/collectables/willow_wisps.tscn").instantiate()
		wisps.global_position = $Marker2D.global_position
		add_child(wisps)

		wisps.connect("collected", Callable(self, "_on_wisps_collected"))

func _on_wisps_collected():
	Globle.explore_dungeon = true
