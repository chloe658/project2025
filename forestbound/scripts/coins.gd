extends Node2D


func _ready():
	Globle.coinChanged.connect(update)
	update()

func update():
	$Label.text = str(Globle.CoinCount)
