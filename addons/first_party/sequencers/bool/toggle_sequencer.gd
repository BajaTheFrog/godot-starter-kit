extends BoolSequencer
class_name ToggleSequencer

export (bool) var starting_value
export (float) var time_between_toggles
export (bool) var auto_start = false

var current_value
var timer
var has_timer_started


func enable():
	.enable()
	timer.paused = false
	

func disable():
	.disable()
	timer.paused = true


func _ready():
	current_value = starting_value
	
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timeout")
	add_child(timer)
	timer.wait_time = time_between_toggles
	timer.one_shot = false
	if auto_start:
		timer.start()
	

func _on_timeout():
	emit_signal("new_value", current_value)
	current_value = not current_value
	
	
func start() -> void:
	if has_timer_started:
		return 
		
	timer.start()
	has_timer_started = true
	
	
func start_with(first_value: bool) -> void:
	current_value = first_value
	start()
	emit_signal("new_value", current_value)
	
	
func stop() -> void:
	if not has_timer_started:
		return 
		
	timer.stop()
	has_timer_started = false
	
	
func stop_with(last_value: bool) -> void:
	current_value = last_value
	emit_signal("new_value", current_value)
	stop()
	
	
func is_running() -> bool:
	return has_timer_started and enabled
