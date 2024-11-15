extends BaseFeedback
class_name QueueFreeFeedback

@export var delay: float = 0.0
@export var call_deferred: bool = true

func _execute(target: Node):
	if delay > 0: 
		var delay_timer = _create_delay_timer(delay)
		await delay_timer.timeout
		_queue_free_target(target)
	else:
		_queue_free_target(target)
		
	
func _queue_free_target(target: Node):
	if call_deferred:
		target.call_deferred("queue_free")
	else:
		target.queue_free()


func _create_delay_timer(delay: float) -> Timer:
	var timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	
	self.add_child(timer)
	
	return timer
