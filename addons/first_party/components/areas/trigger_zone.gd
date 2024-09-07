extends Area2D
class_name TriggerZone

signal invincibility_started
signal invincibility_ended
signal trigger_zone_message(message, sending_object)

export (NodePath) var key_owner_path = null

var collision_shape: CollisionShape2D = null
var invincibility_timer: Timer = null
var invincible = false setget set_invincible


static func get_owner_from(area: Area2D) -> Node:
	var trigger_zone = area as TriggerZone
	if not trigger_zone:
		return null
		
	var tz_owner = trigger_zone.get_key_owner()
	if not tz_owner:
		return null
		
	return tz_owner


func _ready():
	collision_shape = _get_collision_shape()
	
	var new_timer = Timer.new()
	new_timer.one_shot = true
	add_child(new_timer)
	invincibility_timer = new_timer
	
	invincibility_timer.connect("timeout", self, "_on_invincibility_timeout")


func get_key_owner() -> Node:
	if not key_owner_path:
		return null
	return get_node(key_owner_path)


func set_invincible(value):
	invincible = value
	if invincible:
		invincibility_started()
	else:
		invincibility_ended()
		
		
func start_invincibility(duration):
	invincible = true
	invincibility_timer.start(duration)
	
	
func invincibility_started():
	collision_shape.set_deferred("disabled", true)
	emit_signal("invincibility_started")
	
	
func invincibility_ended():
	collision_shape.set_deferred("disabled", false)
	emit_signal("invincibility_ended")
	

func start_colliding() -> void:
	_change_colliding(true)
	

func stop_colliding() -> void:
	_change_colliding(false)
	
	
func is_collidiing() -> bool:
	return monitoring and monitorable
	
	
func _change_colliding(can_collide: bool) -> void:
	set_monitoring(can_collide)
	set_monitorable(can_collide)
	
	
func start_monitoring() -> void:
	set_monitoring(true)
	

func stop_monitoring() -> void:
	set_monitoring(false)
	

func set_monitoring(is_monitoring: bool) -> void:
	set_deferred("monitoring", is_monitoring)
	
	
func start_monitorable() -> void:
	set_monitorable(true)
	
	
func stop_monitorable() -> void:
	set_monitorable(false)


func set_monitorable(is_monitorable: bool) -> void:
	set_deferred("monitorable", is_monitorable)


func _on_invincibility_timeout():
	invincible = false
	

func send_message(message: String, sender: Object):
	emit_signal("trigger_zone_message", message, sender)


func _get_collision_shape() -> CollisionShape2D:
	for child in get_children():
		if child is CollisionShape2D:
			return child
			
	return null
