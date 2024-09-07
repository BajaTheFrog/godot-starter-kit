extends Sprite
class_name SpawnableDummy

export (float) var life_time = 1.0
	
func set_with_transforms(new_position: Vector2, new_scale: Vector2, new_rotation_degrees: float):
	scale = Vector2(0.3, 0.3)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", new_position, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", new_scale, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "rotation_degrees", new_rotation_degrees, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	tween.play()
	
	yield(Wait.on(self, life_time), Wait.END)
	call_deferred("queue_free")
