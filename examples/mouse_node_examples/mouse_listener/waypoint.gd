extends Sprite
class_name Waypoint

func _on_mouse_listener_mouse_click(clicked_button, click_position):
	var tween = create_tween()
	tween.tween_property(self, "position", click_position, 0.2)

