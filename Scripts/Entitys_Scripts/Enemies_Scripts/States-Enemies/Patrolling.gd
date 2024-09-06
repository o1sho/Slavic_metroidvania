class_name Patrolling
extends StateMachineState

#-----------------CORES-------------------
@onready var get_damage_core : GetDamageCore = get_node_or_null("../../Cores/GetDamageCore")

@onready var movement_core: MovementCore = get_node_or_null("../../Cores/MovementCore")
#-----------------------------------------

#-----------------FINDERS-------------------
@onready var target_finder_f_far: ShapeCast2D = get_node_or_null("../../Finders/TargetFinder_far_F")

@onready var target_finder_near_f: RayCast2D = get_node_or_null("../../Finders/TargetFinder_near_F")

@onready var wall_finder: RayCast2D = get_node_or_null("../../Finders/WallFinder")

@onready var floor_finder: RayCast2D = get_node_or_null("../../Finders/FloorFinder")
#-----------------------------------------

func on_enter() -> void:
	print($"../..".name, " has changed the state to ", name)
	state_machine.animation_player.play("Patrol")

func on_process(delta: float) -> void:
	
	if wall_finder.is_colliding() or !floor_finder.is_colliding():
		state_machine.change_state("Idle")
		
	if target_finder_f_far.is_colliding():
		state_machine.change_state("PlayerDetected")
		
	if get_damage_core.attack:
		state_machine.change_state("Stunned")
		

# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	movement_core.x_movement(delta, movement_core.face_direction)



# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func on_exit() -> void:
	pass
