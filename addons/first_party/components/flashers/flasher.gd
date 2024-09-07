extends Component
class_name Flasher

export (NodePath) var target_path
export (Color) var flash_color
export (Material) var flash_material
export (bool) var starting_value
export (float) var time_between_toggles
export (bool) var auto_start = false

var current_value
var timer
var has_timer_started

var _original_color: Color
var _original_material: Material


func get_target_node() -> Node:
	if not target_path:
		return null
	else:
		return get_node(target_path)


func get_canvas_item() -> CanvasItem:
	var target_node = get_target_node()
	if not target_node:
		return null

	return target_node as CanvasItem


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
		start()
		
	var canvas_item = get_canvas_item()
	if not canvas_item:
		return
		
	_original_color = canvas_item.modulate
	

func _on_timeout():
	current_value = not current_value
	
	var canvas_item = get_canvas_item()
	if not canvas_item:
		return
	
	if current_value:
		_flash_on(canvas_item)
	else:
		_flash_off(canvas_item)
			
			
func _flash_on(canvas_item: CanvasItem) -> void:
	canvas_item.modulate = flash_color
	if flash_material:
		canvas_item.material = flash_material
	

func _flash_off(canvas_item: CanvasItem) -> void:
	canvas_item.modulate = _original_color
	if flash_material:
		canvas_item.material = _original_material
	
	
func start() -> void:
	if has_timer_started:
		return 
		
	timer.start()
	has_timer_started = true
	
	
func start_with(first_value: bool) -> void:
	current_value = first_value
	start()
	
	
func stop() -> void:
	if not has_timer_started:
		return 
		
	timer.stop()
	has_timer_started = false
	
	
func stop_with(last_value: bool) -> void:
	current_value = last_value
	stop()
	
	
func is_running() -> bool:
	return has_timer_started and enabled
