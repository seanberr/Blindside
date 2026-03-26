extends Node2D
@export var corresponding_platform : Node2D
@export var glow_comp : Node2D
signal glow_started
signal glow_ended

func start_glow():
	glow_started.emit()
	
func end_glow():
	glow_ended.emit()
