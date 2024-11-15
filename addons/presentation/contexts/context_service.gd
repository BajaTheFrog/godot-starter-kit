extends Node
class_name ContextPresentationService
# Handles the presentation and transition between contexts

var context_root = null
var current_context: Context = null

# A dictionary of keys to scene values to change to
# We expect a game-specifc service to preload these 
# and use whatever keys are appropriate 
var _context_scene_dictionary: Dictionary

func get_context_root_controller() -> Node:
	return context_root


func load_with_context_scene_dictionary(context_scene_dictionary: Dictionary):
	_context_scene_dictionary = context_scene_dictionary


func clear_current_context():
	if get_context_root_controller() != null and current_context != null:
		current_context.on_break_down()
		current_context.queue_free()
		

func go_to(context_key, is_deferred: bool = true):
	if not context_key in _context_scene_dictionary:
		print("Given context key " + str(context_key) + " does not exist in scene dictionary")
		return
		
	var context_scene := _context_scene_dictionary[context_key] as Resource
	if not context_scene:
		print("Scene for key " + str(context_key) + " is not a Resource")
		return
		
	transition_to_context(context_scene, is_deferred)
		
		
func transition_to_context(context_scene: PackedScene, is_deferred: bool):
	if is_deferred:
		call_deferred("_transition_to_context", context_scene)
	else:
		_transition_to_context(context_scene)
	

func _transition_to_context(context_scene: PackedScene):
	clear_current_context()
	_instance_and_add_context(context_scene)
	
	
func _instance_and_add_context(context_scene: PackedScene):
	if get_context_root_controller() == null or context_scene == null:
		return
	
	var context_instance = context_scene.instantiate()
	context_instance.on_set_up()
	context_root.add_child(context_instance)
	context_instance = context_instance as Context
	context_instance.transition_to_other_context.connect(go_to)
	current_context = context_instance
