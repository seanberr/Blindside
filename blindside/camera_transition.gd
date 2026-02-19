extends Node
var transitioning : bool = false
@onready var transition_camera : Camera2D = $Camera2D
@onready var tween : Tween = Tween.new()

func transition_camera2D(from: Camera2D, to: Camera2D, duration: float = 1.0) -> void:
	from.enabled = false
	to.enabled = true
	to.make_current()
