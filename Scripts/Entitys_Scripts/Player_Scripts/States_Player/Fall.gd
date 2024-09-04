extends StateMachineState

@export var _movement_core : MovementCore
@onready var movement_core: MovementCore = _movement_core

@export var _deal_damage_core: DealDamageCore
@onready var deal_damage_core: DealDamageCore = _deal_damage_core

# Called when the state machine enters this state.
func on_enter():
	print(state_machine.current_state)
	state_machine.animation_player.play("Fall")


# Called every frame when this state is active.
func on_process(delta):
	if movement_core.entity.is_on_floor():
		if movement_core.entity.velocity.x == 0:
			change_state("Idle")
		else:
			change_state("Run")
	elif movement_core.get_input()["start_jump"] and movement_core.coyote_timer < movement_core.coyote_time:
		change_state("Jump")
	elif deal_damage_core.get_input()["attack"]:
		change_state("Attack")
	elif !$"../../RayCast2DUp".is_colliding() and $"../../RayCast2DDown".is_colliding():
		change_state("Climb")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	movement_core.x_movement(delta, movement_core.get_input()["x"])
	#deal_damage_core.start_attack()

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass
