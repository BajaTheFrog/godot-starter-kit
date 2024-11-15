extends Component
class_name Spinner

enum SpinDirection { CLOCKWISE, COUNTER_CLOCKWISE }

@export var target_path: NodePath
@export var spin_direction: SpinDirection
@export var spin_forever: bool = true
@export var rotations_per_second: float = 1


func _get_target():
	if not target_path:
		return null
		
	return get_node(target_path)
	
	
func _component_process(delta):	
	var target = _get_target()
	if not target:
		return
		
	var current_rotation = target.rotation_degrees
	var rot_speed = rad_to_deg(rotations_per_second * 2 * PI)
	var new_rotation_delta = rot_speed * delta
	
	var direction_multiplier = 1 if spin_direction == SpinDirection.CLOCKWISE else -1
	new_rotation_delta *= direction_multiplier
	var new_rotation = target.rotation_degrees + new_rotation_delta
	target.rotation_degrees = new_rotation
