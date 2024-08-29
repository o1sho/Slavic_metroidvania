class_name BaseCore_Enemy
extends Node2D


func _ready() -> void:
	_connect_weapon_player()


func _connect_weapon_player():
	var weapons = get_tree().get_nodes_in_group("Weapons")
	print (weapons)
	for weapon in weapons:
		weapon.connect("body_entered", Callable($TakingDamageCore_Enemy, "_on_took_damage").bind(weapon))
		print(weapon.name, " connected")
		print(weapon.get_signal_connection_list("body_entered"))
