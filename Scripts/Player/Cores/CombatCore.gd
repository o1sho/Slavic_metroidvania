class_name CombatCore
extends BaseCore

#@export var _weapon : Weapon
#@onready var weapon: Weapon = _weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_input() -> Dictionary:
	return {
		"attack": Input.is_action_just_pressed("ui_attack") == true
	}
	
func start_attack():
	pass
		
