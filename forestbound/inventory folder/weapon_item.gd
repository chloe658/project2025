class_name WeaponItem extends InventoryItem

@export var attack_damage: int = 1


func use(player: Player) -> void:
	player.attack_enemy(attack_damage)
