extends GameService
class_name CameraService

var is_shake_enabled: bool = true
var active_camera: Camera2D

var shake_timer: Timer

var default_offset: Vector2 = Vector2.ZERO
var shake_amount: float = 0.0

func _ready():
	shake_timer = Timer.new()
	shake_timer.autostart = false
	shake_timer.one_shot = true
	shake_timer.timeout.connect(_on_shake_timer_timeout)
	add_child(shake_timer)
	
	set_process(false)
	

func _process(delta):
	if get_tree().is_network_server():
		return
	
	var random_x_shake = Random.randf_range(-shake_amount, shake_amount)
	var random_y_shake = Random.randf_range(-shake_amount, shake_amount)
	var random_shake = Vector2(random_x_shake, random_y_shake)
	active_camera.offset = random_shake * delta + default_offset


func set_active_camera(camera_2D: Camera2D) -> void:
	active_camera = camera_2D
	default_offset = active_camera.offset


func add_screen_shake(amount: float) -> void:
	shake(amount)


func start_screen_shake(amount: float, time: float, limit: float) -> void:
	shake(amount, time, limit)


func shake(new_shake: float, shake_time: float = 0.4, shake_limit: float = 100.0):
	if not is_shake_enabled or get_tree().is_network_server():
		return 
		
	var settings_scalar = 1.0 #GameSettings.camera().get_screenshake_intensity_scalar()
	new_shake *= settings_scalar
	shake_time *= settings_scalar
	shake_limit *= settings_scalar
	
	shake_amount += new_shake
	if shake_amount > shake_limit:
		shake_amount = shake_limit
	
	shake_timer.wait_time = shake_time
	
	set_process(true)
	shake_timer.start()


func _on_shake_timer_timeout():
	shake_amount = 0
	set_process(false)
	
	var tween = create_tween()
	tween.tween_property(active_camera, "offset", default_offset, 0.1)
