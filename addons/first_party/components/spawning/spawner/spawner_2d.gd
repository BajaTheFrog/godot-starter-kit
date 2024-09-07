extends Component2D
class_name Spawner2D

signal node_spawned(spawned_node)

enum PositionMode {ABSOLUTE, RELATIVE_TO_SPAWNER, RELATIVE_TO_PARENT}
enum ScaleMode {ABSOLUTE, RELATIVE_TO_SPAWNER, RELATIVE_TO_PARENT}
enum RotationMode {ABSOLUTE, RELATIVE_TO_SPAWNER, RELATIVE_TO_PARENT}
enum ParentMode {ASSIGNED_PARENT, TOP_LEVEL}
# The spawner id that can be signaled remotely to trigger a spawn
export (String) var spawner_id = "" #TODO: Add global event for triggering spawn

# Scene to spawn
export (PackedScene) var scene_to_spawn
# Position
export (PositionMode) var position_mode
export (Vector2) var spawn_position = Vector2.ZERO
# Scale
export (ScaleMode) var scale_mode
export (Vector2) var spawn_scale = Vector2.ONE
# Rotation
export (RotationMode) var rotation_mode
export (float) var spawn_rotation_degrees = 0.0
# Parent
export (ParentMode) var parent_mode
# Misc
export (bool) var defer_call_when_spawning = false
onready var parent_for_spawn: Node2D = self

func spawn():
	spawn_with_defer_call(defer_call_when_spawning)
	
	
func spawn_with_defer_call(should_defer_call: bool):
	if should_defer_call:
		call_deferred("_private_spawn")
	else:
		_private_spawn()
	

func _private_spawn():
#	if use_topmost_world_node:
#		parent_for_spawn = GAME.world_service.top_most_world_node
	
	if not parent_for_spawn and parent_mode != ParentMode.TOP_LEVEL:
		print(self.name + ": CANNOT SPAWN WITHOUT A PARENT")
		return
	
	# TODO: Make these transform functions exposed to delegate for custom
	# calculations such as randomness. Include calculated values in case
	# delegate just wants to use those
	var spawn_position = _get_spawn_position()
	var spawn_scale = _get_spawn_scale()
	var spawn_rotation_degrees = _get_spawn_rotation()
	
	var scene_instance = scene_to_spawn.instance()
	scene_instance.global_position = spawn_position
	scene_instance.global_scale = spawn_scale
	scene_instance.global_rotation_degrees = spawn_rotation_degrees
	
	if parent_mode == ParentMode.ASSIGNED_PARENT:
		parent_for_spawn.add_child(scene_instance)
	else:
		parent_for_spawn.add_child(scene_instance)
		scene_instance.set_as_toplevel(true)
	emit_signal("node_spawned", scene_instance)


func _get_spawn_position() -> Vector2:
	match position_mode:
		PositionMode.ABSOLUTE:
			return spawn_position
		PositionMode.RELATIVE_TO_SPAWNER:
			return global_position + spawn_position
		PositionMode.RELATIVE_TO_PARENT:
			return parent_for_spawn.global_position + spawn_position
			
	return Vector2.ZERO
	
	
func _get_spawn_scale() -> Vector2:
	match scale_mode:
		ScaleMode.ABSOLUTE:
			return spawn_scale
		ScaleMode.RELATIVE_TO_SPAWNER:
			return global_scale * spawn_scale
		ScaleMode.RELATIVE_TO_PARENT:
			return parent_for_spawn.global_scale * spawn_scale
			
	return Vector2.ONE
	

func _get_spawn_rotation() -> float:
	match rotation_mode:
		RotationMode.ABSOLUTE:
			return spawn_rotation_degrees
		PositionMode.RELATIVE_TO_SPAWNER:
			return self.global_rotation_degrees + spawn_rotation_degrees
		PositionMode.RELATIVE_TO_PARENT:
			return parent_for_spawn.global_rotation_degrees + spawn_rotation_degrees
			
	return 0.0
	
