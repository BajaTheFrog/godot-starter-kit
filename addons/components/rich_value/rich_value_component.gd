extends Component
class_name RichValueComponent
# Underlying value for something like health, mana, energy etc
# See bottom of file for notes on potential changes in the future
# TODO: Maybe this should just be RefCounted and healt etc nodes hold onto them

class RichValueChangeInfo:
	var previous_value: float
	var previous_value_as_percent: float
	var current_value: float
	var current_value_as_percent: float
	var min_value: float
	var max_value: float
	
	func _init(previous: float, current: float, min_value: float, max_value: float, range_translator: RangeTranslator):
		self.previous_value = previous
		self.previous_value_as_percent = range_translator.range_position_from_value(previous)
		self.current_value = current
		self.current_value_as_percent = range_translator.range_position_from_value(current)
		self.min_value = min_value
		self.max_value = max_value
	

# takes in a RichValueChangeInfo obj
signal changed(change_info)

@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var min_value: float = 0: 
	set(value): 
		_on_min_value_set(value)
		
@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var max_value: float = 1: 
	set(value):
		_on_max_value_set(value)
		
@export var current_value: float = 1.0:
	get:
		return _inner_value
	set(value):
		_update_value(value)
		
@export_range(0.0, 1.0) var current_percent: float = 1.0:
	get:
		return range_translator.range_position_from_value(_inner_value)
	set(value):
		var translated_value = range_translator.value_from_range_position(value)
		_update_value(translated_value)

# SOURCE OF TRUTH! Updated in _update_value
var _inner_value: float

var range_translator: RangeTranslator = null

func _ready():
	range_translator = RangeTranslator.new(min_value, max_value)


func _on_min_value_set(value: float):
	range_translator = RangeTranslator.new(value, max_value)
	
	
func _on_max_value_set(value: float):
	range_translator = RangeTranslator.new(min_value, max_value)
	

func is_full() -> bool:
	return current_value >= max_value
	

func is_empty() -> bool:
	return current_value == min_value


func change_value_by(amount: float):
	set_value(current_value + amount)
	
	
func change_value_by_percent(percent: float):
	var amount = range_translator.range_portion_from_percent(percent)
	change_value_by(amount)
	

func set_value(new_value: float):
	_update_value(new_value)
	

func set_value_to_percent(percent: float):
	var total_amount = range_translator.value_from_range_position(percent)
	set_value(total_amount)
	
	
func _update_value(new_value: float):
	if not enabled:
		return
		
	var previous_value = current_value
	_inner_value = clamp(new_value, min_value, max_value)
	var change_info = RichValueChangeInfo.new(previous_value, current_value, min_value, max_value, range_translator)
	changed.emit(change_info)
	
	
###### Potential future changes ######

# Things to consider
# continuous vs. chunked vs. hybrid (you can be continuous in a chunk)
# value range (is it always 0-1, can you go over? Can you asssign what 1 means?)
# is there active decay? Is there active healing?
# support for common mechanisms like healing or "receoverable" values
# a class for communicating value pool events
# setting the value 
# "caps" that block the health from progressing through to a higher amount

# Set up basically a "plugin" system for features like
# - decay
# - chunks
# - caps 
# etc

# Make your average HealthComponent a scene with all the plugins already _There_
# but _disabled_ so that a dev can go in and enable/disable the child nodes
# ex.
# _HealthComponent
#  |_DecayPlugin
#  |_ChunkPlugin
#  |_CapPlugin
#  |_HealthSpecificPlugin
