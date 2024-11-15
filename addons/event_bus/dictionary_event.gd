extends Event
class_name DictionaryEvent
# A simple event type that stores arbitrary
# info in a dictionary struct


var info_dictionary = Dictionary()


func _init(event_id, info_dictionary):
	super(event_id)
	self.info_dictionary = info_dictionary
