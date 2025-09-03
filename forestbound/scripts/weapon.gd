extends Node2D

#https://www.youtube.com/watch?v=hVsID4Td-Os&list=PLMQtM2GgbPEWKQuyv9sXHwGWDXLY3Zjpw&index=26
#use tutorial 

var weapon: Area2D

func _ready():
	if get_children().is_empty(): return
	
	weapon = get_children()[0]
	#weapon.disable()


func enable():
	if !weapon: return
	
	visible = true
	weapon.enable()


func disable():
	if !weapon: return

	visible = false
	weapon.disable()


func add_weapon(new_weapon) -> void:
	if weapon && weapon.name == new_weapon.name: return
	
	if weapon:
		remove_child(weapon)
	
	weapon = new_weapon
	add_child(new_weapon)
	disable()
