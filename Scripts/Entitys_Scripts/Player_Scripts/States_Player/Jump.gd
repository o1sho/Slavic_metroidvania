extends StateMachineState

### Node path to the character.
#@export_node_path("CharacterBody2D") var _character: NodePath = "../.."
## Reference to the character node.
#@onready var character: CharacterBody2D = get_node(_character)

@onready var movement_core: MovementCore = get_node_or_null("../../Cores/MovementCore")

@onready var deal_damage_core: DealDamageCore = get_node_or_null("../../Cores/DealDamageCore")

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
	if movement_core.entity.velocity.y > 0:
		change_state("Fall")
	elif movement_core.entity.is_on_floor():
		change_state("Idle")
	elif !$"../../RayCast2DUp".is_colliding() and $"../../RayCast2DDown".is_colliding() and movement_core.get_input()["x"]:
		change_state("Climb")
	#elif movement_core.get_input()["stop_jump"]:
		#change_state("Fall")
	elif deal_damage_core.get_input()["attack"]:
		change_state("Attack")



# Called every physics frame when this state is active.
func on_physics_process(delta):
	movement_core.jump_proces(delta)
	movement_core.x_movement(delta, movement_core.get_input()["x"])
	

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass

# Called when the state machine exits this state.
func on_exit():
	movement_core.jump_reset()
	movement_core.jump_time = 0.0
