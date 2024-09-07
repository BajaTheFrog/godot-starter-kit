extends Node
class_name Tools

onready var tree: TreeTools = TreeTools.new()
onready var string: StringTools = StringTools.new()
onready var array: ArrayTools = ArrayTools.new()

class TreeTools:
	
	func get_all_descendents(node: Node) -> Array:
		var all_nodes: Array = []
		for node in node.get_children():
			if node.get_child_count() > 0:
				var node_children = node.get_children()
				all_nodes.append_array(node_children)
			else:
				all_nodes.append(node)
			
		return all_nodes


class StringTools:
	
	func punctuated_number(value: int, separator: String = ",") -> String:
		var string_value = str(value)
		var length = string_value.length()
		var return_string = ""
	
		for index in range(length):
				if((length - index) % 3 == 0 and index > 0):
					return_string = str(return_string, separator, string_value[index])
				else:
					return_string = str(return_string, string_value[index])
			
		return return_string


class ArrayTools:
	
	func push_with_limit(array: Array, element, element_limit: int) -> Array:
		var extended_array = array.push_front(element)
		var trimmed_array = array.slice(0, element_limit - 1)
		return trimmed_array
