extends TextureProgressBar

@onready var player = $".."

func _ready():
	Globle.healthChanged.connect(update)
	update()

func update():
	#print("value changed")
	value = Globle.currentHealth * 100 / player.maxHealth
