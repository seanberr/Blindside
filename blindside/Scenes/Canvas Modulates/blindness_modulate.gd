extends CanvasModulate

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Toggle Blindness"):
		if Global.extras_unlocked:
			if visible:
				visible = false
			else:
				visible = true
