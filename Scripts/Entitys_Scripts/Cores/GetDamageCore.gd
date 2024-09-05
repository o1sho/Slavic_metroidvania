class_name GetDamageCore
extends BaseCore


@export var hp = 1

var attack: bool = false

func change_hp(count: float):
	hp += count
	death()

func death():
	if hp <= 0:
		$"../..".queue_free()
