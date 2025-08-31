class_name WeaponItem extends InventoryItem

@export var attack_damage: int = 1

"""

#@export var weapon_class: PackedSene = preload("res://scenes/sword.tscn")
@export var weapon_class = preload("res://scenes/sword.tscn")
var weapon

func _init() -> void:
	weapon = weapon_class.instantiate()
"""
func use(player: Player) -> void:
	#pass
	print("use")
	#player.weapon.add_weapon(weapon)
	player.attack_enemy(attack_damage)
