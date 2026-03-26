extends Node2D
@export var trigger_area : Area2D
@export var animator : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger_area.player_entered_area.connect(disappear)

func disappear():
	trigger_area.player_entered_area.disconnect(disappear)
	animator.play("Disappear")
