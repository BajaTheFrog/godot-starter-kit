extends Component
class_name HitFlasher

export (NodePath) var target_path
export (Color) var flash_color
export (float) var flash_duration
export (bool) var auto_start

onready var flash_material = preload("res://addons/third_party/shaders/single_color_shader_material.tres")

var timer
var has_timer_started

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
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timeout")
	add_child(timer)
	timer.wait_time = flash_duration
	timer.one_shot = true
		
	var canvas_item = get_canvas_item()
	if not canvas_item:
		return
		
	if auto_start:
		flash()
	

func _on_timeout():
	var canvas_item = get_canvas_item()
	if not canvas_item:
		return
		
	canvas_item.material = null
			
			
func flash() -> void:
	if has_timer_started:
		return 
		
	timer.start()
	has_timer_started = true
	
	var canvas_item = get_canvas_item()
	if not canvas_item:
		return
		
	canvas_item.material = flash_material
	canvas_item.material.set("shader_param/color", flash_color)
	
	
func is_in_flash() -> bool:
	return has_timer_started and enabled
