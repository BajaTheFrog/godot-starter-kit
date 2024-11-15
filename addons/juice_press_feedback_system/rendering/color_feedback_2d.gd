@tool
extends TweenFeedback2D
class_name ColorFeedback2D

@export var color: Color

func _get_starting_value(original_value, current_value):
	return original_value


func _get_new_value(starting_value):
	return color
	
	
func _get_property_name() -> String:
	return "modulate"
