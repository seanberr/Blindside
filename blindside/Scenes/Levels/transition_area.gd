extends Area2D
var has_entered : bool = false
@export var scene_to_load : PackedScene
@export var player_coords : Array[Vector2]

func _ready() -> void:
	body_entered.connect(on_body_entered)
	
func change_scene():
	TransitionHandler.transition_to_scene(scene_to_load, player_coords)

func on_body_entered(body):
	if body.is_in_group("Player") and !has_entered:
		has_entered = true
		change_scene()
