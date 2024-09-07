extends Node
class_name Groups

onready var types: Types = Types.new()
onready var roots: Roots = Roots.new()
onready var shapes: Shapes = Shapes.new()
onready var hitboxes: Hitboxes = Hitboxes.new()
onready var hurtboxes: Hurtboxes = Hurtboxes.new()
onready var hotboxes: Hotboxes = Hotboxes.new()


class Types:
	const entity = "group.type.entity"
	const object = "group.type.object"
	const environment = "group.type.environment"
	

class Roots:
	const player_character = "group.root.player_character"
	const enemy = "group.root.enemy"
#	const bullet = "group.root.bullet"
#	const pickup = "group.root.pickup"
	
	
class Shapes:
	const player = "group.shape.player"
	const enemy = "group.shape.enemy"
#	const bullet = "group.shape.bullet"
#	const wall = "group.shape.wall"
	
	
class Hitboxes:
#	const player_bullet = "group.hitbox.player.bullet"
#	const player_teleport = "group.hitbox.player.teleport"
#	const enemy_bullet = "group.hitbox.enemy.bullet"
	pass
	
	
class Hurtboxes:
#	const player = "group.hurtbox.player"
#	const enemy = "group.hurtbox.enemy"
#	const logo = "group.hitbox.logo"
#	const shield = "group.hitbox.shield"
	pass
	
	
class Hotboxes:
#	const player_pickup = "group.hotbox.player.pickup"
#	const energy_pickup = "group.hotbox.energy.pickup"
#	const enemy_fire_zone = "group.hotbox.enemy.fire.zone"
	pass
