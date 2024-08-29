class_name TakingDamageCore_Enemy
extends BaseCore_Enemy



func _on_took_damage(body: Node, weapon: Area2D) -> void:
	print(name, " took damage in the amount: ", weapon.amount_of_damage)
	$"../CharacteristicsCore_Enemy".hp -= weapon.amount_of_damage
	
	if $"../CharacteristicsCore_Enemy".hp == 0:
		$"../DeathCore_Enemy"._death()
