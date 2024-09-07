class_name Random
# This does nothing to preserve a seed across 
# the game - for that use GameRandom
	
static func randf() -> float:
	var rand = _get_fresh_random_generator()
	return rand.randf()
	
	
static func randf_range(lower_limit, upper_limit) -> float:
	var rand = _get_fresh_random_generator()
	return rand.randf_range(lower_limit, upper_limit)
	
	
static func randi() -> int:
	var rand = _get_fresh_random_generator()
	return rand.randi()
	
	
static func randi_capped(upper_limit) -> int:
	if upper_limit <= 0:
		return 0
		
	return randi() % upper_limit
	
	
static func randi_range(lower_limit, upper_limit):
	var rand = _get_fresh_random_generator()
	return rand.randi_range(lower_limit, upper_limit)
	
	
static func _get_fresh_random_generator() -> RandomNumberGenerator:
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	return rand
	

static func random_unit_vector() -> Vector2:
	var random_x = randf_range(-1, 1)
	var random_y = randf_range(-1, 1)
	return Vector2(random_x, random_y).normalized()
	
	
static func flip_a_coin() -> bool:
	return roll_chance(50.0)
	

# Give a number between 1-100 and "roll" to see
# if you hit based on that chance out of 100%
# So passing in 14 evaluates if you hit on a 14% chance
static func roll_chance(chance_out_of_100: float) -> bool:
	var roll = randf_range(0.0, 100.0)
	return roll < chance_out_of_100


# For calculating probabilties like a "2 in 7" chance
# Both parameters must be >= 0
# If the second parameter is <= 0 it will always return false
static func evaluate_in_chance(numerator: int, denominator: int) -> bool:
	if denominator <= 0:
		return false
		
	var threshold = float(numerator) / float(denominator)
	var random_value = randf()
		
	return random_value >= threshold
