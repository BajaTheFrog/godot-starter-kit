extends GameService
class_name PauseService

export (float) var min_time_between_changes = 0.3
var _time_since_last_request = 0


func _ready():
	_time_since_last_request = min_time_between_changes


func _process(delta):
	if _time_since_last_request <= min_time_between_changes:
		_time_since_last_request += delta


func is_paused():
	return get_tree().paused
	
	
func toggle_pause():
	if is_paused():
		pause_off()
	else:
		pause_on()
	
	
func pause_on():
	_set_paused(true)
	
	
func pause_off():
	_set_paused(false)
	
	
func _set_paused(is_paused: bool):
	# squash "double presses" or inputs from multiple nodes
	if _time_since_last_request < min_time_between_changes:
		return

	get_tree().paused = is_paused
	Game.events.gameplay.emit_signal("pause_changed", is_paused)
	_time_since_last_request = 0
