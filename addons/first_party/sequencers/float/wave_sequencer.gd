extends FloatSequencer
class_name WaveSequencer

export (float, 0.0, 1.0) var initial_value_position = 0.0
export (float) var min_value = 0.0
export (float) var max_value = 1.0
export (float) var min_to_max_time = 1

var current_time = 0.0

# y = A sin(Bx + C) + D

# A in the equation.
# The amplitude
# absolute value of (max - min) divided by 2
func _get_amplitude() -> float:
	return abs((max_value - min_value) / 2.0)
	
	
# B in the equation.
# 2PI / period (p = twice our min to max time)
# so we can simplify 2PI / 2mtmt -> PI / mtmt
func _get_period_multiplier() -> float:
	return PI / min_to_max_time
	

# C in the equation
# the phase shift
# We get the phase shift based on starting value
func _get_phase_shift() -> float:	
	# C = arcsin((Y - D) / A) - BX
	# https://www.desmos.com/calculator/q9xcn0et39
	var starting_value = lerp(min_value, max_value, initial_value_position)
	var vertical_shift = _get_vertical_shift()
	var amplitude = _get_amplitude()
	return asin((starting_value - vertical_shift) / amplitude)
	

# D in the equation
# The vertical shift
# This is the average of the min and max values
func _get_vertical_shift() -> float:
	return (max_value + min_value) / 2.0


func _component_process(delta):
	var wave_value = _get_wave_value(current_time)
	emit_signal("new_value", wave_value)
	current_time += delta


func _get_wave_value(time: float) -> float:
	# y = A sin(Bx + C) + D
	var amplitude = _get_amplitude()
	var period_multiplier = _get_period_multiplier()
	var phase_shift = _get_phase_shift()
	var vertical_shift = _get_vertical_shift()
	
	var sin_contents = (period_multiplier * time) + phase_shift
	
	return amplitude * sin(sin_contents) + vertical_shift
	
