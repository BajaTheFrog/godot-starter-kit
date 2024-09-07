extends Component
class_name Spinner

enum SpinDirection { CLOCKWISE, COUNTER_CLOCKWISE }

export (NodePath) var target_path
export (SpinDirection) var spin_direction
export (bool) var spin_forever = true
export (float) var rotations_per_second = 1


func _get_target():
	if not target_path:
		return null
		
	return get_node(target_path)
	
	
func _component_process(delta):	
	var target = _get_target()
	if not target:
		return
		
	var current_rotation = target.rotation_degrees
	var rot_speed = rad2deg(rotations_per_second * 2 * PI)
	var new_rotation_delta = rot_speed * delta
	
	var direction_multiplier = 1 if spin_direction == SpinDirection.CLOCKWISE else -1
	new_rotation_delta *= direction_multiplier
	var new_rotation = target.rotation_degrees + new_rotation_delta
	target.rotation_degrees = new_rotation
