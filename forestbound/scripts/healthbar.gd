extends TextureProgressBar

@onready var player = $".."

func _ready():
	Global.healthChanged.connect(update)
	update()


func update():
	value = Global.currentHealth * 100 / player.maxHealth
