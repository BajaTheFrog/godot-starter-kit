extends Context
class_name TitleContext

const CONTEXT_ID = "context.title"

func context_id_string() -> String:
	return CONTEXT_ID


func _ready():
	pass
	
	
func _on_start_clicked():
	_on_go_to_game_pressed()


func _on_go_to_game_pressed():
	change_context(GameplayContext.CONTEXT_ID)