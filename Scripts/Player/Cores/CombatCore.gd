class_name CombatCore
extends BaseCore


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_input() -> Dictionary:
	return {
		"attack": Input.is_action_just_pressed("ui_attack") == true
	}
	
func start_attack():
	if get_input()["attack"]:
		pass
		
