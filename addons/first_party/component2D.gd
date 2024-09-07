extends Node2D
class_name Component2D

# Base class(es) for any 2D "Component" type nodes
# see also Component

export (bool) var enabled = true

func _process(delta):
	if enabled:
		_component_process(delta)
		
		
func _component_process(delta):
	pass
	
	
func _physics_process(delta):
	if enabled:
		_component_physics_process(delta)


func _component_physics_process(delta):
	pass
