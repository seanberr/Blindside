extends Node2D
class_name Level
@export var spawn_positions : Array[Vector2]
var blur_layer : PackedScene = preload("res://Scenes/Camera/blur_layer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TransitionHandler.transitioning:
		PlayerLoader.spawn_players()
	elif spawn_positions:
		PlayerLoader.spawn_positions = spawn_positions
		PlayerLoader.spawn_players()
		
	var blur = blur_layer.instantiate()
	add_child(blur)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
