extends Node
# class_name PresentationServices
# Holds onto services that handle the following
# - transitioning between contexts
# - presenting and handling UI 

onready var context_service_instance = $ContextService
onready var ui_service_instance = $UIService

func context_service() -> ContextPresentationService:
	return context_service_instance
	

func ui_service() -> UIPresentationService:
	return ui_service_instance
