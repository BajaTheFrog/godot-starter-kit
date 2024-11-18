extends Node
class_name Groups
# Groups
# This is the recommended hub for accessing group identifiers
# so that nodes, areas and more are added to the appropriate groups
# Usage will look like: Global.groups.category.specific_group


@onready var roots: Roots = Roots.new()
@onready var hitboxes: Hitboxes = Hitboxes.new()
@onready var hurtboxes: Hurtboxes = Hurtboxes.new()
@onready var hotboxes: Hotboxes = Hotboxes.new()
	

class Roots:
	# Use this class to store group ID's that will be set
	# at the root of objects.
	
	# EXAMPLES
	const player_character = "group.root.player_character"
	# const bullet = "group.root.bullet"
	# const pickup = "group.root.pickup"
	
	
class Hitboxes:
	# Use this class to store group ID's that will be set
	# on hitboxes (Area2D's that deal damage) 
	
	# EXAMPLES:
	# const player_bullet = "group.hitbox.player.bullet"
	# const player_teleport = "group.hitbox.player.teleport"
	# const enemy_bullet = "group.hitbox.enemy.bullet"
	pass
	
	
class Hurtboxes:
	# Use this class to store group ID's that will be set
	# on hurtboxes (Area2D's that receive damage) 
	
	# EXAMPLES
	const player = "group.hurtbox.player"
	# const player = "group.hurtbox.player"
	# const enemy = "group.hurtbox.enemy"
	# const shield = "group.hitbox.shield"
	pass
	
	
class Hotboxes:
	# Use this class to store group ID's that will be set
	# on hotboxes (Area2D's that interact with other objects in the game) 
	
	# EXAMPLES:
	# const player_pickups = "group.hotbox.player.pickups"
	# const pickup = "group.hotbox.pickup"
	pass
