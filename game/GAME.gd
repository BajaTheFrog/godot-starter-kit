extends Node
class_name Game

static var root: Game = null

static func is_active() -> bool:
	return root != null
	
enum Contexts { TITLE, GAMEPLAY }

@export var context_root: Node
@export var title_context_scene: PackedScene
@export var gameplay_context_scene: PackedScene
@export var starting_context: Contexts

func _ready():
	randomize()
	_set_up_contexts()
	_go_to_starting_context()
	_mark_game_as_ready()
	
	
func _set_up_contexts():
	var context_scene_dictionary = { 
		TitleContext.CONTEXT_ID : title_context_scene, 
		GameplayContext.CONTEXT_ID : gameplay_context_scene,
	}
	
	Global.context_service.context_root = context_root
	Global.context_service.load_with_context_scene_dictionary(context_scene_dictionary)
	
	
func _go_to_starting_context():
	var starting_context_id = _id_for_context_value(starting_context)
	Global.context_service.go_to(starting_context_id)
	
	
func _mark_game_as_ready():
	Game.root = self
	Global.events.application.game_is_ready.emit()
	
	
func _id_for_context_value(context_value: Contexts) -> String:
	match context_value:
		Contexts.TITLE:
			return TitleContext.CONTEXT_ID
		Contexts.GAMEPLAY:
			return GameplayContext.CONTEXT_ID
			
	return ""
	
