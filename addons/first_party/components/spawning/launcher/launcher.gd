extends Spawner2D
class_name Launcher2D

signal projectile_launched(launched_node)
signal debug_direction_info(given_direction, final_direction)

enum LaunchLimits {UNLIMITED, LIMITED}
enum DirectionMode {ABSOLUTE, RELATIVE_TO_SPAWNER, RELATIVE_TO_PARENT}

export (float) var projectile_speed = 1000
export (float) var shots_per_second = 10.0
export (int) var max_projectiles
export (int) var remaining_projectiles
export (LaunchLimits) var launch_limits
export (DirectionMode) var direction_mode
export (Resource) var launch_direction_data 

var timer: Timer
var can_fire = true

func _ready():
	timer = Timer.new()
	add_child(timer)
	
	connect("node_spawned", self, "_on_projectile_spawned")
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = 1.0 / shots_per_second
	timer.autostart = false
	
	
func fire():
	if can_fire and are_projectiles_available():
		spawn()
		timer.start()
		can_fire = false
		
		
func spawn():
	.spawn()
	if launch_limits == LaunchLimits.LIMITED:
		remaining_projectiles -= 1
		
		
func are_projectiles_available() -> bool:
	if launch_limits == LaunchLimits.UNLIMITED:
		return true
	else:
		return remaining_projectiles > 0
		
		
		
func get_projectile_stock() -> float:
	if launch_limits == LaunchLimits.UNLIMITED:
		return 1.0
	else:
		return float(remaining_projectiles) / float(max_projectiles)
		
		
func restock_projectiles(amount: int = -1) -> void:
	if amount <= 0:
		remaining_projectiles = max_projectiles
	else:
		remaining_projectiles += amount
		remaining_projectiles = clamp(remaining_projectiles, 0.0, max_projectiles)
		
		
func _on_timer_timeout():
	can_fire = true
	

func _on_projectile_spawned(spawned_node: Node2D):
	if not "velocity" in spawned_node:
		return
	
	var launch_direction = _get_launch_direction_vector()
	emit_signal("debug_direction_info", launch_direction_data.get_direction_vector().normalized(), launch_direction)
	spawned_node.velocity = launch_direction * projectile_speed
	spawned_node.rotation_degrees = rad2deg(launch_direction.angle())
	emit_signal("projectile_launched", spawned_node)
	

# its normalized
func _get_launch_direction_vector() -> Vector2:
	var launch_direction_vector = launch_direction_data.get_direction_vector()
	match rotation_mode:
		DirectionMode.ABSOLUTE:
			pass
		DirectionMode.RELATIVE_TO_SPAWNER:
			var direction_deviation_radians = launch_direction_vector.angle()
			var global_rotation_radians = deg2rad(self.global_rotation_degrees) + direction_deviation_radians
			var global_rotation_vector = Vector2.RIGHT.rotated(global_rotation_radians)
			launch_direction_vector = global_rotation_vector
		DirectionMode.RELATIVE_TO_PARENT:
			var direction_deviation_radians = launch_direction_vector.angle()
			var global_parent_rotation_radians = deg2rad(parent_for_spawn.global_rotation_degrees) + direction_deviation_radians
			var parent_lobal_rotation_vector = Vector2.RIGHT.rotated(global_parent_rotation_radians)
			launch_direction_vector = parent_lobal_rotation_vector
			
	return launch_direction_vector.normalized()
