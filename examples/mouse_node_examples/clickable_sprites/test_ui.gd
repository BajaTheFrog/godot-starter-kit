extends Control

onready var label = $Label


func _on_red_sprite_clicked():
	label.add_color_override("font_color", Color.lightcoral)
	label.text = "RED CLICKED"


func _on_green_sprite_clicked():
	label.add_color_override("font_color", Color.green)
	label.text = "GREEN CLICKED"


func _on_blue_sprite_clicked():
	label.add_color_override("font_color", Color.cyan)
	label.text = "BLUE CLICKED"
