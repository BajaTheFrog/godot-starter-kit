tool
extends Node2D
class_name GrowableRing

# change if shape of ring changes
const RING_REFERENCE_DIAMETER = 100.0

export (float, 0.01, 100.0, 0.01) var ring_scale = 1.0 setget handle_changed_radius
export (float) var true_ring_width = 10.0
export (Color) var ring_color = Color.white setget handle_changed_color

onready var hotbox: TriggerZone = $hotbox

func _on_polygon_updated():
	_update_with_ring_scale()


func handle_changed_radius(new_value: float):
	ring_scale = new_value
	_update_with_ring_scale()
	

func handle_changed_color(color: Color):
	_get_ring_line().default_color = color
	_get_gradient_sprite().modulate = color

	
func _get_ring_line() -> Line2D:
	return get_node("ring_line") as Line2D
	
	
func _get_point_driver() -> RegularPolygon2D:
	return get_node("ring_line/point_driver") as RegularPolygon2D
	
	
func _get_gradient_sprite() -> Sprite:
	return get_node("gradient_sprite") as Sprite
	
	
func _update_with_ring_scale():
	var ring = _get_ring_line()
	var point_driver = _get_point_driver()
	ring.points = []
	ring.points = point_driver.polygon
	var new_width = true_ring_width / ring_scale
	ring.width = new_width
	scale = Vector2(ring_scale, ring_scale)


func _on_point_driver_polygon_updated():
	_update_with_ring_scale()
