extends LauncherDirectionStatsBase
class_name LauncherDirectionStatsRange

enum DirectionMode {VECTOR, DEGREES}

export (Vector2) var min_vector
export (Vector2) var max_vector
export (float, -360, 360) var min_degrees
export (float, -360, 360) var max_degrees
export (DirectionMode) var mode

func _init(p_min_vector = Vector2(0.5, -0.5), p_max_vector = Vector2(0.5, 0.5), p_min_degrees = -45, p_max_degrees = 45):
	min_vector = p_min_vector
	max_vector = p_max_vector
	min_degrees = p_min_degrees
	max_degrees = p_max_degrees

func get_direction_vector() -> Vector2:
	if mode == DirectionMode.VECTOR:
		var x = rand_range(min_vector.x, max_vector.x)
		var y = rand_range(min_vector.y, max_vector.y)
		return Vector2(x, y)
	else:
		var random_degrees = rand_range(min_degrees, max_degrees)
		var random_radians = deg2rad(random_degrees)
		return Vector2.RIGHT.rotated(random_radians)
