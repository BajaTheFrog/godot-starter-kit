extends LauncherDirectionStatsBase
class_name LauncherDirectionStatsFixed

enum DirectionMode {VECTOR, DEGREES}

export (Vector2) var vector
export (float, -360, 360) var degrees
export (DirectionMode) var mode

func _init(p_vector = Vector2.RIGHT, p_degrees = 0):
	vector = p_vector
	degrees = p_degrees

func get_direction_vector() -> Vector2:
	if mode == DirectionMode.VECTOR:
		return vector
	else:
		var radians = deg2rad(degrees)
		return Vector2.RIGHT.rotated(radians)
