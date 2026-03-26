extends Node
var alex : CharacterBody2D
@export var position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player.name == "PlayerAlex":
			alex = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Input.dis
