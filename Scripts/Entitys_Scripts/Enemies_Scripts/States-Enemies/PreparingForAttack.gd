class_name PreparingForAttack
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

@export var additional_speed_multiplier = 4

func on_enter() -> void:
	print($"../..".name, " has changed the state to ", name)
	state_machine.animation_player.play("Patrol")
	$Timer.start()

# Called every frame when this state is active.
func on_process(delta: float) -> void:


	if !floor_finder.is_colliding() and movement_core.entity.is_on_floor():
		state_machine.change_state("Idle")
	
	if !target_finder_f_far.is_colliding() and wall_finder.is_colliding():
		state_machine.change_state("Idle")	
		
	if target_finder_near_f.is_colliding() and !get_damage_core.attack:
		state_machine.change_state("AttackPlayer")
		
	if get_damage_core.attack:
		state_machine.change_state("Stunned")


# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	if !target_finder_near_f.is_colliding():
		movement_core.x_movement(delta * additional_speed_multiplier, movement_core.face_direction)
		if wall_finder.is_colliding():
			movement_core.jump_simple()


func on_input(event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func on_exit() -> void:
	$Timer.stop()


func _on_timer_timeout() -> void:
	if !target_finder_f_far.is_colliding():
		state_machine.change_state("Search")
