extends Sprite


func _ready():
	_tween_to_new_location()


func _on_Timer_timeout():
	_tween_to_new_location()


func _tween_to_new_location():
	var tween = create_tween()
	tween.tween_property(self, "position", _get_random_location(), 1.5)
	
	
func _get_random_location():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	
	var new_x = rand_range(0, width)
	var new_y = rand_range(0, height)
	
	return Vector2(new_x, new_y)
