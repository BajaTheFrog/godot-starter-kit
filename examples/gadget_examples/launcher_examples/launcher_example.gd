extends Node2D
	
onready var launcher: Launcher2D = $circle/arrow/launcher

onready var debug_label: Label = $CanvasLayer/debug_labels/control/label
onready var debug_launch_label: Label = $CanvasLayer/debug_labels/control/label2

func _ready():
	launcher.connect("debug_direction_info", self, "_on_launch_debug")


func _process(delta):
	_update_debug_label()


func _on_mouse_listener_mouse_button_change(button, button_state, mouse_position):
	if button_state == MouseListener.MouseButtonState.PRESSED:
		launcher.fire()


func _update_debug_label() -> void:
	var arrow_global_degrees = $circle/arrow.global_rotation_degrees
	debug_label.text = "Arrow Global Degrees = " + str(arrow_global_degrees)
	debug_label.text += "\n"
	var launcher_global_degress = $circle/arrow/launcher.global_rotation_degrees
	debug_label.text += "Launcher Global Degrees = " + str(launcher_global_degress)
	pass


func _on_launch_debug(initial_vector: Vector2, final_vector: Vector2):
	var current_text = debug_launch_label.text
	var initial_vector_degrees = rad2deg(initial_vector.angle())
	var final_vector_degrees = rad2deg(final_vector.angle())
	debug_launch_label.text = "Init: " + str(initial_vector_degrees) + ", Final: " + str(final_vector_degrees)
	debug_launch_label.text += "\n" + current_text
	
