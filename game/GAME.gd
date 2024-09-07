extends Node
# GAME
# This is the anchor for all the game systems

onready var groups: Groups = $groups
onready var events: Events = $events
onready var messages: Messages = $messages

onready var services = $services
onready var theme_service: ThemeService = $services/theme_service
onready var sound_service: SoundService = $services/sound_service
onready var pause_service: PauseService = $services/pause_service
onready var time_service: TimeService = $services/time_service
onready var screen_service: ScreenService = $services/screen_service
onready var camera_service: CameraService = $services/camera_service
onready var world_service: WorldService = $services/world_service
onready var player_service: PlayerService = $services/player_service

var has_been_initialized = false

func _ready():
	initialize_services()
	
	
func run_at(time_scale: float) -> TimeService.TimeBlock:
	return TimeService.TimeBlock.new(time_scale, time_service)


func resume_normal_time_scale() -> void:
	time_service.resume_normal_time_scale()
	
	
func is_paused() -> bool:
	return pause_service.is_paused()
	
	
func toggle_pause() -> void:
	pause_service.toggle_pause()
	

func pause_on() -> void:
	pause_service.pause_on()
	
	
func pause_off() -> void:
	pause_service.pause_off()


func initialize_services():
	var service_children = _get_services_children()
	for child in service_children:
		var service = child as GameService
		if not service or not service.is_running:
			continue
			
		service.on_game_initialize()
		
	has_been_initialized = true
	
		
func _process(delta):
	if not has_been_initialized:
		return
	
	var service_children = _get_services_children()
	for child in service_children:
		var service = child as GameService
		if not service or not service.is_running:
			continue
			
		service.on_game_process(delta)
		
	if Input.is_action_just_pressed("toggle_pause"):
		pass
		
		
	
func _physics_process(delta):
	if not has_been_initialized:
		return
	
	var service_children = _get_services_children()
	for child in service_children:
		var service = child as GameService
		if not service or not service.is_running:
			continue
			
		service.on_game_physics_process(delta)
		

func _get_services_children() -> Array:
	if services.get_child_count() > 0:
		return services.get_children()
	else:
		return []
