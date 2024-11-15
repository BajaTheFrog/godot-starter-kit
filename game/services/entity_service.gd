extends GameService
class_name EntityService


func get_player_root_node() -> Node2D:
	var group_name = Game.groups.roots.player
	var player_root_nodes = get_tree().get_nodes_in_group(group_name)
	if player_root_nodes.empty():
		return null
	else:
		return player_root_nodes[0]

# EXAMPLES
