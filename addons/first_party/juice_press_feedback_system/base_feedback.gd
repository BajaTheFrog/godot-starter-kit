tool
extends Node
class_name BaseFeedback

signal feedback_ended()

export (NodePath) var TargetPath
export (bool) var run = false setget _editor_execute

export (bool) var block_until_done = false
export (bool) var dont_run = false

func _editor_execute(_value = null):
	execute()


func execute():
	_execute(get_node(TargetPath))


func _execute(_target: Node):
	# Subclasses to handle behavior
	pass


func trigger_feedback_ended():
	emit_signal("feedback_ended")
