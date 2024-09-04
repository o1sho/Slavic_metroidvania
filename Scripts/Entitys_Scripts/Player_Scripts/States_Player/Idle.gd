extends StateMachineState

@export var _movement_core: MovementCore
@onready var movement_core: MovementCore = _movement_core

@export var _deal_damage_core: DealDamageCore
@onready var deal_damage_core: DealDamageCore = _deal_damage_core

# Called when the state machine enters this state.
func on_enter():
	state_machine.animation_player.play("Idle")
	print(state_machine.current_state)
	movement_core.coyote_timer = 0

# Called every frame when this state is active.
func on_process(delta):
	#if get_input()["just_jump"] or get_input()["jump"] or get_input()["released_jump"]:
		#change_state("Jump")
	if !movement_core.entity.is_on_floor() and movement_core.entity.velocity.y > 0:
		change_state("Fall")
	elif movement_core.get_input()["start_jump"] and movement_core.entity.is_on_floor():
		change_state("Jump")
	elif movement_core.get_input()["x"] or movement_core.get_input()["y"]:
		change_state("Run")
	elif deal_damage_core.get_input()["attack"]:
		change_state("Attack")

	
# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass
	#deal_damage_core.start_attack()

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass

# Called when the state machine exits this state.
func on_exit():
	pass
