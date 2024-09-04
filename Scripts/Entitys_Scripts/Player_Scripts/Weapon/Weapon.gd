class_name Weapon
extends Area2D

@export var amount_of_damage: float = 1

func _ready():
	$CollisionShape2D.disabled = true
	
