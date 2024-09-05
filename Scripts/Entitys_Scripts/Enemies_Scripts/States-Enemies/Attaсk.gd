class_name Attack
extends StateMachineState

@export var _movement_core : MovementCore
@onready var movement_core: MovementCore = _movement_core

@export var _get_damage_core : GetDamageCore
@onready var get_damage_core: GetDamageCore = _get_damage_core

# Called when the state machine enters this state.
func on_enter() -> void:
	print($"../..".name, " has changed the state to ", name)
	state_machine.animation_player.play("Attack")
	movement_core.entity.velocity.x = 0


# Called every frame when this state is active.
func on_process(delta: float) -> void:
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func on_exit() -> void:
	pass
