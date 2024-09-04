extends StateMachineState

@export var _movement_core : MovementCore
@onready var movement_core: MovementCore = _movement_core

# Called when the state machine enters this state.
func on_enter() -> void:
	print($"../..".name, " has changed the state to ", name)
	movement_core.entity.velocity.x = 0
	$Timer1.start()

# Called every frame when this state is active.
func on_process(delta: float) -> void:
	if $"../../RayCast2D_TargetFinder_F_far".is_colliding():
		state_machine.change_state("PreparingForAttack")


# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func on_exit() -> void:
	pass


func _on_timer_timeout() -> void:
	if !$"../../RayCast2D_TargetFinder_F_far".is_colliding():
		$Timer2.start()
		movement_core.set_direction(-movement_core.face_direction)



func _on_timer_2_timeout() -> void:
	if !$"../../RayCast2D_TargetFinder_F_far".is_colliding():
		movement_core.set_direction(-movement_core.face_direction)
		state_machine.change_state("Patrol")
