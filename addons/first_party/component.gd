extends Node
class_name Component

# Base class(es) for any "Component" type nodes
# see also Component2D

export (bool) var enabled = true

func enable() -> void:
	enabled = true
	

func disable() -> void:
	enabled = false


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
