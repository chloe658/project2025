extends Button

@onready var backgroundSprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer

var itemStackGui: ItemStackGui

func insert(isg: ItemStackGui):
	itemStackGui = isg
	container.add_child(itemStackGui)
