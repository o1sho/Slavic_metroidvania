class_name MovementCore
extends BaseCore

# GRAVITY ----- #
var gravity_max = ProjectSettings.get_setting("physics/2d/default_gravity") 
# ------------- #

# BASIC MOVEMENT VARAIABLES ---------------- #
var face_direction := 1
var x_dir := 1

@export var max_speed: float = 560
@export var acceleration: float = 2880
@export var turning_acceleration : float = 9600
@export var deceleration: float = 3200
# ------------------------------------------ #

# JUMP VARAIABLES ------------------- #
@export var jump_force = -500
#@export var max_velY = -1000
@export var max_jump_time = 0.5  # Максимальное время, в течение которого можно удерживать кнопку прыжка
@export var jump_boost = 2  # Коэффициент увеличения высоты прыжка при удержании
@export var coyote_time = 0.1  # Время на прыжок после ухода с платформы

var jump_time = 0.0
var coyote_timer = 0.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
var gravity_works: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if gravity_works: _apply_gravity(delta)
	entity.move_and_slide()
	if !entity.is_on_floor(): coyote_timer_proces(delta)
	
func get_input() -> Dictionary:
	return {
		"x": int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		"y": int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")),
		"start_jump": Input.is_action_just_pressed("jump") == true,
		"jump": Input.is_action_pressed("jump") == true,
		"stop_jump": Input.is_action_just_released("jump") == true,
	}

func _apply_gravity(delta: float) -> void:
	entity.velocity.y += gravity * delta

func x_movement(delta: float, _x_dir: int) -> void:	
	
	x_dir = _x_dir
	# Stop if we're not doing movement inputs.
	if x_dir == 0: 
		entity.velocity.x = 0
	
	# If we are doing movement inputs and above max speed, don't accelerate nor decelerate
	# Except if we are turning
	# (This keeps our momentum gained from outside or slopes)
	if abs(entity.velocity.x) >= max_speed and sign(entity.velocity.x) == x_dir:
		return
	
	# Are we turning?
	# Deciding between acceleration and turn_acceleration
	var accel_rate : float = acceleration if sign(entity.velocity.x) == x_dir else turning_acceleration
	
	# Accelerate
	entity.velocity.x += x_dir * accel_rate * delta
	
	#if !animationPlayer.current_animation == "Attack_sword":
	set_direction(x_dir) # This is purely for visuals
	
func set_direction(hor_direction) -> void:
	# This is purely for visuals
	# Turning relies on the scale of the player
	# To animate, only scale the sprite
	if hor_direction == 0:
		return
	entity.apply_scale(Vector2(hor_direction * face_direction, 1)) # flip
	face_direction = hor_direction # remember direction	


func jump():
	if get_input()["start_jump"]:
		entity.velocity.y = jump_force
		jump_time = 0.0


func jump_proces(delta: float) -> void:
	if get_input()["jump"]:
		if jump_time < max_jump_time:
			jump_time += delta
			#print(jump_time)
			entity.velocity.y += jump_boost
			
		
	if get_input()["stop_jump"]:
		jump_time = 0.0

func coyote_timer_proces(delta: float) -> void:
	coyote_timer += delta
