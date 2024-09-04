class_name DealDamageCore
extends BaseCore

@export var _weapon: Area2D
@onready var weapon: Area2D = _weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon.connect("area_entered", Callable(self, "on_enemy_hitbox_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_input() -> Dictionary:
	return {
		"attack": Input.is_action_just_pressed("ui_attack") == true
	}

func on_enemy_hitbox_entered(area):
	if area.is_in_group("Damageable"):
		var enemy = area.get_parent()
		enemy.change_hp(-weapon.amount_of_damage)
