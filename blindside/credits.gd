extends Node2D
@export var title_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(30).timeout
	#TransitionHandler.transition_to_scene(title_scene, [Vector2.ZERO, Vector2.ZERO])
