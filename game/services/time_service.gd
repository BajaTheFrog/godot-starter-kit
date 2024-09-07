extends GameService
class_name TimeService

const HIGHEST_PRIORITY = 10
const HIGH_PRIORITY = 5
const REGULAR_PRIORITY = 2
const LOW_PRIORITY = 1
const LOWEST_PRIORITY = 0
const NO_PRIORITY = -1

# for high precisions we keep track of time manually
var current_timer_threshold
var current_time_tracked

var currently_in_time_freeze = false
var current_priority = LOWEST_PRIORITY
var previous_time_scale

class TimeBlock:
	var time_scale: float = 1.0
	var time_service: TimeService = null
	
	
	func _init(p_time_scale: float, p_time_service: TimeService):
		time_scale = p_time_scale
		time_service = p_time_service
	
	
	func for_seconds(duration: float, priority: int = REGULAR_PRIORITY) -> void:
		time_service.request_time_freeze(time_scale, duration, priority)


func _process(delta):
	if currently_in_time_freeze:
		current_time_tracked += delta
		
		if current_time_tracked >= current_timer_threshold:
			_end_time_freeze()


func request_time_freeze(time_scale: float, duration: float, priority: int = REGULAR_PRIORITY):
	if currently_in_time_freeze and priority < current_priority:
		return
		
	_start_time_freeze(time_scale, duration, priority)
	
	
func request_time_change(time_scale: float):
	if currently_in_time_freeze:
		return
	Engine.time_scale = time_scale
	
	
func resume_normal_time_scale() -> void:
	_end_time_freeze()
	

func _start_time_freeze(time_scale: float, duration: float, priority: int) -> void:	
	if currently_in_time_freeze and priority > current_priority:
		current_time_tracked = 0.0
	else:
		previous_time_scale = Engine.time_scale
	
	current_timer_threshold = duration * time_scale
	currently_in_time_freeze = true
	current_priority = priority
	current_time_tracked = 0.0
	
	Engine.time_scale = time_scale
	
	
func _end_time_freeze() -> void:
	current_timer_threshold = 0.0
	currently_in_time_freeze = false
	current_priority = NO_PRIORITY
	current_time_tracked = 0.0
	
	
	Engine.time_scale = 1.0 #previous_time_scale
