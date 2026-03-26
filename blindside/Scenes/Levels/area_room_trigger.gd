extends Area2D
@export var scene_to_load : PackedScene
@export var player_coords : Array[Vector2]
var scene_changed : bool = false

func change_scene():
	TransitionHandler.transition_to_scene(scene_to_load, player_coords)
	
func _on_body_entered(body: Node2D) -> void:
	if scene_changed == true:
		return
	if body.is_in_group("Player"):
		change_scene()
		scene_changed = true
