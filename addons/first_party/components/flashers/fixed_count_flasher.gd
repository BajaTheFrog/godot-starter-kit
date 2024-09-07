extends Flasher
class_name FixedCountFlasher

export (int) var number_of_flashes

var remaining_flashes

func _ready():
	remaining_flashes = number_of_flashes # toggle on and off
	
	
func _on_timeout():
	._on_timeout()
	
	# if we hit all our flashes and are now off, we stop
	if remaining_flashes <= 0 and not current_value:
		stop()
		

func _flash_on(canvas_item: CanvasItem) -> void:
	._flash_on(canvas_item)
	remaining_flashes -= 1
		
		
func start():
	remaining_flashes = number_of_flashes
	.start()
