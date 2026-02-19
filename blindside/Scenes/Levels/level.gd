extends Node2D
class_name Level
@export var spawn_positions : Array[Vector2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if TransitionHandler.transitioning:
		PlayerLoader.spawn_players()
	elif spawn_positions:
		PlayerLoader.spawn_positions = spawn_positions
		PlayerLoader.spawn_players()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
