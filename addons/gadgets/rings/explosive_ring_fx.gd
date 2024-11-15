extends Node2D
class_name ExplosiveRingFX

const SPAWN_ARG_COLOR_KEY = "ring.color" # color
const SPAWN_ARG_AREA_GROUP_KEY = "area.group" # string

signal about_to_free()

export (float) var explosion_size = 10.0
export (float) var explosion_duration = 1.0
export (bool) var fade = true

onready var growable_ring = $GrowableRing


var given_args = null


func handle_spawn_args(args: Dictionary):
	given_args = args
		

func process_args():
	if not given_args:
		return 
		
	if SPAWN_ARG_COLOR_KEY in given_args:
		growable_ring.ring_color = given_args[SPAWN_ARG_COLOR_KEY]
		
	if SPAWN_ARG_AREA_GROUP_KEY in given_args:
		growable_ring.hotbox.add_to_group(given_args[SPAWN_ARG_AREA_GROUP_KEY])


func _ready():
	process_args()
	var tween = create_tween()
	tween.tween_property(growable_ring, "ring_scale", explosion_size, explosion_duration)
	if fade:
		tween.tween_property(growable_ring, "modulate", Color(0,0,0,0), explosion_duration)
	yield(tween, "finished")
	_on_tween_finished()


func _on_tween_finished():
	emit_signal("about_to_free")
	call_deferred("queue_free")
