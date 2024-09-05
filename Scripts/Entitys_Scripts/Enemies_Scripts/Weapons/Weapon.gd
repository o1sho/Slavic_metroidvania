extends Area2D


@export var amount_of_damage: float = 1
@export var push_direction: Vector2
@export var push_power: float

func _ready():
	$CollisionShape2D.disabled = true
	
