extends StateMachineState

@export var _movement_core : MovementCore
@onready var movement_core: MovementCore = _movement_core

@export var _combat_core : CombatCore
@onready var combat_core: CombatCore = _combat_core

var attack_finished: bool
#var can_jump: bool = false

# Called when the state machine enters this state.
func on_enter():
	state_machine.animation_player.play("Attack_sword")
	attack_finished = false
	print(state_machine.current_state)
	#can_jump = true

# Called every frame when this state is active.
func on_process(delta):
	if attack_finished and movement_core.character.velocity.x == 0 and movement_core.character.is_on_floor():
		change_state("Idle")
	elif attack_finished and movement_core.character.velocity.x != 0 and movement_core.character.is_on_floor():
		change_state("Run")
	#elif attack_finished and !movement_core.character.is_on_floor() and movement_core.character.velocity.y < 0:
		#change_state("Jump")
	elif attack_finished and !movement_core.character.is_on_floor() and movement_core.character.velocity.y < 0:
		change_state("Fall")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	movement_core.x_movement(delta)
	#print(movement_core.character.velocity.y) 
	#if movement_core.character.velocity.y < 0: #up
		#movement_core.jump_proces(delta)
	#if movement_core.character.velocity.y > 0 and movement_core.coyote_timer < movement_core.coyote_time: #down
		#movement_core.jump()
	#if movement_core.character.velocity.y == 0: #stay
		#movement_core.jump()
		#
	#if (movement_core.coyote_timer > 0 or movement_core.character.is_on_floor()) and movement_core.character.velocity.y <= 0:
		#movement_core.jump_proces(delta)
	pass
	
# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

func on_attack_finish(delta):
	attack_finished = true
