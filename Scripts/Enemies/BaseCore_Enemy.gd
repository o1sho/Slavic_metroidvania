class_name BaseCore_Enemy
extends Node2D


@export var _enemy: RigidBody2D
@onready var enemy: RigidBody2D = _enemy

@export var _animation: AnimatedSprite2D
@onready var animation: AnimatedSprite2D = _animation

func _ready() -> void:
	_connect_weapon_player()


func _connect_weapon_player():
	var weapons = get_tree().get_nodes_in_group("Weapons")
	var taking_damage_core = $TakingDamageCore_Enemy
	
	if taking_damage_core:
		for weapon in weapons:
			weapon.connect("body_entered", Callable(taking_damage_core, "_on_took_damage").bind(weapon))
