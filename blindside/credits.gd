extends Node2D
var title_scene = preload("uid://bdwqpu7hq1iqu")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(30).timeout
	TransitionHandler.transition_to_scene(title_scene, [Vector2.ZERO, Vector2.ZERO])
