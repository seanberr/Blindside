extends CanvasModulate

func _physics_process(delta: float) -> void:
	if Global.extras_unlocked:
		if Input.is_action_just_pressed("Toggle Blindness"):
			if visible:
				visible = false
			else:
				visible = true
