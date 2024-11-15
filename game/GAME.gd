extends Node
# GAME
# This is the AUTOLOAD anchor for all the major game systems. 

@export var groups: Groups
@export var events: Events
@export var messages: Messages

@onready var services = $services
@export var theme_service: ThemeService
@export var sound_service: SoundService
@export var pause_service: PauseService
@export var time_service: TimeService
@export var screen_service: ScreenService
@export var camera_service: CameraService
@export var world_service: WorldService
@export var entity_service: EntityService
@export var ui_service: UIPresentationService
@export var context_service: ContextPresentationService

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
