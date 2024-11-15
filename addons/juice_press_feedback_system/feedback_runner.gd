@tool
extends Node
class_name FeedbackRunner

signal all_feedbacks_finished()

@export var run: bool = false: set = _editor_execute
@export var is_debug_trigger_enabled: bool = true
@export var run_trigger_in_editor: bool = false

func _editor_execute(_value = null):
	execute_feedbacks()
	
	
func _input(event):
	if not is_debug_trigger_enabled:
		return 
		
	if not InputMap.has_action("juice_press_test_feedback"):
		print("If you want to trigger feedbacks when debugging, set 'juice_press_test_feedback' in your InputMap!")
		return
		
	if event.is_action_pressed("juice_press_test_feedback", false, true):
		var in_editor_and_can_run = Engine.is_editor_hint() and run_trigger_in_editor
		var not_in_editor =  not Engine.is_editor_hint()
		if in_editor_and_can_run or not_in_editor:
			execute_feedbacks()


func execute_feedbacks():
	for child in get_children():
		var child_feedback := child as BaseFeedback
		if child_feedback:
			
			if child_feedback.dont_run:
				continue
			
			child_feedback.execute()
			
			if child_feedback.block_until_done:
				await child_feedback.feedback_ended
				
	emit_signal("all_feedbacks_finished")
