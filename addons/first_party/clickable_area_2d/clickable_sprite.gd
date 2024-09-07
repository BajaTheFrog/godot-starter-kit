extends Sprite
class_name ClickableSprite
# A sprite with a built-in handler function
# to connect to a ClickableArea2D for click events


signal sprite_clicked()


func _on_clicked():
	emit_signal("sprite_clicked")


func _on_clickable_area_2d_clicked():
	_on_clicked()
