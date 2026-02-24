extends Node2D
@export var platform : Node2D
@export var light : PointLight2D

func _physics_process(delta: float) -> void:
	if platform.player_standing:
		enable_glow()
	else:
		disable_glow()
	
func enable_glow():
	light.enabled = true
	
func disable_glow():
	light.enabled = false
