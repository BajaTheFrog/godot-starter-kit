class_name TreeTools

static func get_all_children(node: Node) -> Array:
	var all_nodes: Array = []
	for node in node.get_children():
		if node.get_child_count() > 0:
			var node_children = node.get_children()
			all_nodes.append_array(node_children)
		else:
			all_nodes.append(node)
			
	return all_nodes
