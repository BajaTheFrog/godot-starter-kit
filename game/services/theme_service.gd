extends GameService
class_name ThemeService

onready var current_theme: GameTheme

func on_game_initialize():
	set_current_theme(SplitTriggerTheme.get_theme())
	

func set_current_theme(new_theme: GameTheme) -> void:
	current_theme = new_theme
	Game.events.game_theme.emit_signal("theme_changed", new_theme)
