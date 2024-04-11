tool
extends Node
class_name MouseListener
# A class for tracking mouse movement
# and clicks for other nodes to easily respond to

signal mouse_position_update(mouse_position)
signal mouse_click(clicked_button, click_position)


enum MouseClickButton {
	LEFT,
	RIGHT,
}


export (bool) var get_continuous_position_updates = false


func _process(_delta):
	if not get_continuous_position_updates:
		return
	
	var mouse_position = get_viewport().get_mouse_position()
	print(mouse_position)
	emit_signal("mouse_position_update", mouse_position)
	

func _input(event):
	if not event is InputEventMouseButton or not event.pressed:
		return
		
	var clicked_button = MouseClickButton.LEFT if event.button_index == BUTTON_LEFT else MouseClickButton.RIGHT
	var mouse_position = get_viewport().get_mouse_position()
	emit_signal("mouse_click", clicked_button, mouse_position) 

