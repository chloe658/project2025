class_name HealthItem extends InventoryItem

@export var health_increase: int = 1


func use(player: Player) -> void:
	player.increase_health(health_increase)


func can_be_used(_player: Player):
	return Global.currentHealth + health_increase <= Global.maxHealth
