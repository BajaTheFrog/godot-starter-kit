extends GameService
class_name WorldService
		
# EXAMPLES

#func destroy_all_enemies() -> void:
#	var enemies = get_tree().get_nodes_in_group(Global.groups.roots.enemy)
#	for enemy in enemies:
#		var true_enemy = enemy `as EnemyRoot
#		if true_enemy:
#			true_enemy.call_deferred("die", false)
#
#
#func destroy_all_bullets() -> void:
#	var bullets = get_tree().get_nodes_in_group(Global.groups.roots.bullet)
#	for bullet in bullets:
#		var true_bullet = bullet as Bullet
#		if true_bullet:
#			true_bullet.call_deferred("die", false)
