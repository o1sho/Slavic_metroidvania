class_name Weapon
extends Area2D

@export var amount_of_damage: int = 1

func _ready():
	$CollisionShape2D.disabled = true
	
