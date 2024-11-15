@tool
extends Node
class_name BaseFeedback

signal feedback_ended()

@export var TargetPath: NodePath
@export var run: bool = false: set = _editor_execute

@export var block_until_done: bool = false
@export var dont_run: bool = false

func _editor_execute(_value = null):
	execute()


func execute():
	_execute(get_node(TargetPath))


func _execute(_target: Node):
	# Subclasses to handle behavior
	pass


func trigger_feedback_ended():
	emit_signal("feedback_ended")
