extends Node
# GAME
# This is the anchor for all the game systems

onready var services = $services
var has_been_initialized = false


func initialize_services():
	var service_children = _get_services_children()
	for child in service_children:
		var service = child as GameService
		if not service:
			continue
			
		service.on_game_initialize()
		
	has_been_initialized = true
		
		
func _process(delta):
	if not has_been_initialized:
		return
	
	var service_children = _get_services_children()
	for child in service_children:
		var service = child as GameService
		if not service:
			continue
			
		service.on_game_process(delta)
		
	
func _physics_process(delta):
	if not has_been_initialized:
		return
	
	var service_children = _get_services_children()
	for child in service_children:
		var service = child as GameService
		if not service:
			continue
			
		service.on_game_physics_process(delta)
		

func _get_services_children() -> Array:
	if services.get_child_count() > 0:
		return services.get_children()
	else:
		return []
