extends Node
class_name Events
# Events
# This is the recommended hub for broad events to pass through
# Some examples are included to demonstrate the pattern
# Create a class that contains the events for _types_ events or _categories_
# we might care about. 
# Usage will look like: Game.events.category.specific_signal

@onready var application: ApplicationEvents = ApplicationEvents.new()
@onready var player: PlayerEvents = PlayerEvents.new()
@onready var enemies: EnemyEvents = EnemyEvents.new()
@onready var world: WorldEvents = WorldEvents.new()
@onready var game_round: RoundEvents = RoundEvents.new()
@onready var game_theme: GameThemeEvents = GameThemeEvents.new()


class ApplicationEvents:
	# These are events that are outside the context of 
	# the specific game rules or gameplay loop
	
	# EXAMPLES
	signal pause_changed(is_paused)
	pass
	

class PlayerEvents:
	# These are events that indicate to the game that
	# something of note has changed with the player
	
	# EXAMPLES
	# signal player_scored(amount)
	# signal player_died()
	pass
	

class EnemyEvents:
	# These are events to communicate important updates
	# from one or more enemies
	
	# EXAMPLES
	# signal enemy_died()
	pass
	
	
class WorldEvents:
	# These are events to communicate updates happening
	# from changes in the state of the level or world
	
	# EXAMPLES
	# signal door_opened(door_id)
	# signal item_spawned(global_position)
	# signal enemy_spawned_at(global_position)
	pass
	

class RoundEvents:
	# These are events to communicate updates from the round
	# or game "rules" 
	
	# EXAMPLES
	# signal new_round_state_data(round_state_data)
	pass
	
	
class GameThemeEvents:
	# These are events to communicate changes in the
	# GameTheme (colors, assets and presentation of the game)
	
	# EXAMPLES
	signal theme_changed(new_theme)
	pass
