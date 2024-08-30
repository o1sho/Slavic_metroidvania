class_name DeathCore_Enemy
extends BaseCore_Enemy



func _death():
	enemy.queue_free()
