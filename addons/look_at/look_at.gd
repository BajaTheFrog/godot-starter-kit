extends Node
class_name LookAt
# A node for hooking up look_at behavior
# for the mouse or arbitrary nodes


enum TargetMode {
	MOUSE,
	TARGET,
}


enum UpdateMode {
	PROCESS,
	PHYSICS, 
	# Timer
}


export (NodePath) var looking_node_path = null
export (TargetMode) var target_mode = TargetMode.MOUSE
export (NodePath) var target_node_path = null
export (UpdateMode) var update_mode = UpdateMode.PROCESS


func _looking_node() -> Node:
	if looking_node_path == null:
		return null
	return get_node(looking_node_path)
	
	
func _target_node() -> Node:
	if target_node_path == null:
		return null
	return get_node(target_node_path)


func _process(_delta):
	if update_mode != UpdateMode.PROCESS:
		return
		
	_look()
	
	
func _physics_process(_delta):
	if update_mode != UpdateMode.PHYSICS:
		return
		
	_look()
		

func _look():
	var node_2d = _looking_node() as Node2D
	if node_2d:
		var point = _get_point()
		node_2d.look_at(point)
		
		
func _get_point() -> Vector2:
	var target = _target_node()
	match target_mode:
		TargetMode.MOUSE:
			return get_viewport().get_mouse_position()
		TargetMode.TARGET:
			if target == null:
				return Vector2.ZERO
			
			var target_2d = target as Node2D
			if not target_2d:
				return Vector2.ZERO
			else:
				return target_2d.position
				
	return Vector2.ZERO
	
