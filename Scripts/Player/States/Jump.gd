extends StateMachineState

### Node path to the character.
#@export_node_path("CharacterBody2D") var _character: NodePath = "../.."
## Reference to the character node.
#@onready var character: CharacterBody2D = get_node(_character)

@export var _movement_core : MovementCore
@onready var movement_core: MovementCore = _movement_core


## Timers
#@export var jump_coyote : float = 0.08
#@export var jump_buffer : float = 0.1
#@export var attack_cooldown : float = 2.0
#
#var jump_coyote_timer : float = 0
#var jump_buffer_timer : float = 0
#var is_jumping := false
# ----------------------------------- #

# Called when the state machine enters this state.
func on_enter():
	print (state_machine.current_state)
	state_machine.animation_player.play("Jump")
	movement_core.jump()
	

# Called every frame when this state is active.
func on_process(delta):
	pass
	#State transitions
	if movement_core.character.velocity.y > 0:
		change_state("Fall")
	if movement_core.character.is_on_floor():
		change_state("Idle")
	if movement_core.get_input()["stop_jump"]:
		change_state("Fall")

# Called every physics frame when this state is active.
func on_physics_process(delta):
	movement_core.jump_proces(delta)
	movement_core.x_movement(delta)
	

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass

# Called when the state machine exits this state.
func on_exit():
	pass

