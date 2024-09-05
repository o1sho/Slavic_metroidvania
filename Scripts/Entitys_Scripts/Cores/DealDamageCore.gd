class_name DealDamageCore
extends BaseCore

@export var _weapon: Area2D
@onready var weapon: Area2D = _weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon.connect("area_entered", Callable(self, "on_enemy_hitbox_entered"))
	weapon.connect("area_exited", Callable(self, "on_enemy_hitbox_exited"))


func get_input() -> Dictionary:
	return {
		"attack": Input.is_action_just_pressed("ui_attack") == true
	}

func on_enemy_hitbox_entered(area):
	if area.is_in_group("Damageable"):
		var enemy_get_damage_core = area.get_parent()
		enemy_get_damage_core.change_hp(-weapon.amount_of_damage)
		enemy_get_damage_core.attack = true
		
		
		var enemy_body = enemy_get_damage_core.get_node("../..")
		enemy_body.velocity += weapon.push_power * weapon.push_direction
		
		print("The ", enemy_body.name, " was attacked and got damage of ", weapon.amount_of_damage, " units!")

func on_enemy_hitbox_exited(area):
	if area.is_in_group("Damageable"):
		var enemy_get_damage_core = area.get_parent()
		enemy_get_damage_core.attack = false
