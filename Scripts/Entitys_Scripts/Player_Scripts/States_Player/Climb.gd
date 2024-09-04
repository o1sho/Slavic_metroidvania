extends StateMachineState

@export var hor_dist_end_point = 15
@export var ver_dist_end_point = 15

@export var _movement_core : MovementCore
@onready var movement_core: MovementCore = _movement_core

@onready var ray_cast_up: RayCast2D = $"../../RayCast2DUp"
@onready var ray_cast_down: RayCast2D = $"../../RayCast2DDown"

# Called when the state machine enters this state.
func on_enter() -> void:
	print(state_machine.current_state)
	$Timer.start()
	movement_core.gravity_works = false
	



# Called every frame when this state is active.
func on_process(delta: float) -> void:
	if movement_core.entity.is_on_floor():
		state_machine.change_state("Idle")


# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	movement_core.entity.velocity = Vector2(0, 0)


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func on_exit() -> void:
	movement_core.gravity_works = true

func _on_timer_timeout() -> void:
	if movement_core.face_direction == 1:
		movement_core.entity.position.x += hor_dist_end_point
		movement_core.entity.position.y -= ver_dist_end_point
	elif movement_core.face_direction == -1: 
		movement_core.entity.position.x -= hor_dist_end_point
		movement_core.entity.position.y -= ver_dist_end_point
