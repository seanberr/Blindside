extends Node2D
class_name Level
@export var spawn_positions : Array[Vector2]
@export var track_name : String
var blur_layer : PackedScene = preload("res://Scenes/Camera/blur_layer.tscn")
var blur

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if track_name:
		AudioManager.music_manager.transition_to_track(track_name)
	if TransitionHandler.transitioning:
		PlayerLoader.spawn_players()
	elif spawn_positions:
		PlayerLoader.spawn_positions = spawn_positions
		PlayerLoader.spawn_players()
		
	blur = blur_layer.instantiate()
	add_child(blur)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
