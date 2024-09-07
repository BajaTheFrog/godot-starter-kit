extends Component
class_name HomingTracker

export (float) var speed = 1500.0
export (float) var steer_force = 4000.0
export (bool) var increase_seek_over_time = true
export (float) var seek_multiplier = 1.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target_to_move = null
var homing_target = null


func seek(delta):
	var steer = Vector2.ZERO
	if homing_target:
		var desired = (homing_target.position - target_to_move.position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
		
	if increase_seek_over_time:
		seek_multiplier += delta
		
	return steer * seek_multiplier


func _component_physics_process(delta):
	if not target_to_move or not homing_target:
		return
	
	acceleration += seek(delta)
	velocity += acceleration * delta
	velocity = velocity.limit_length(speed)
	target_to_move.rotation = velocity.angle()
	target_to_move.position += velocity * delta
