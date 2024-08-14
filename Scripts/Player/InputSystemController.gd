class_name InputSystemController
extends Node


func get_input() -> Dictionary:
	return {
		"x": int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		"y": int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")),
		"start_jump": Input.is_action_just_pressed("jump") == true,
		"jump": Input.is_action_pressed("jump") == true,
		"stop_jump": Input.is_action_just_released("jump") == true,
		"attack": Input.is_action_just_pressed("ui_attack") == true,
	}
