extends Node2D


func _ready():
	Global.coinChanged.connect(update)
	update()


func update():
	$Label.text = str(Global.CoinCount)
