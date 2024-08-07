extends StateMachineState

@export var _movement_core : MovementCore
@onready var movement_core: MovementCore = _movement_core


# Called when the state machine enters this state.
func on_enter():
	print(state_machine.current_state)
	state_machine.animation_player.play("Run")

# Called every frame when this state is active.
func on_process(delta):
	if movement_core.character.velocity.x == 0 and !movement_core.character.is_on_wall(): 
		change_state("Idle")
	elif movement_core.get_input()["start_jump"]:
		change_state("Jump")
	elif movement_core.character.velocity.y > 0:
		change_state("Fall")

# Called every physics frame when this state is active.
func on_physics_process(delta):
	movement_core.x_movement(delta)

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass



# Called when the state machine exits this state.
func on_exit():
	pass



