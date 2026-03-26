extends Node2D
@export var label: Label
@export var animator: AnimationPlayer
@export var timer : Timer

func set_text(text: String):
	label.text = text

func display(duration: float):
	fade_in()
	timer.start(duration)
	timer.timeout.connect(fade_out)

func fade_in():
	animator.play("Fade In")

func fade_out():
	animator.play("Fade Out")
	timer.start(1)
	timer.timeout.connect(queue_free)
