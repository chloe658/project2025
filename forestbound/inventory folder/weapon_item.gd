class_name WeaponItem extends InventoryItem

@export var weapon_class: PackedScene = preload("res://scenes/sword.tscn")
var weapon
@export var attack_damage: int = 1

func _init() -> void:
	weapon = weapon_class.instantiate()


func use(player: Player) -> void:
	player.weapon.add_weapon(weapon)
	player.attack_enemy(attack_damage)
