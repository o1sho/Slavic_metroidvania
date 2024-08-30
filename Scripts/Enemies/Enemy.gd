extends RigidBody2D

var current_point_index: int = 0

@export var _player: CharacterBody2D
@onready var player: CharacterBody2D = _player

var player_detected: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_searching()

func player_searching():
	if $RayCast2D.is_colliding():
		player_detected = true
	else:
		player_detected = false
