class_name DeathCore_Enemy
extends Node2D



func _death():
	$"../..".queue_free()
