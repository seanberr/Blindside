extends Area2D
class_name PlayerDetectionArea
@export var camera_level : Camera2D
@onready var camera_player = get_tree().get_first_node_in_group("Player Camera")
var players_in_area : Array[CharacterBody2D]

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		players_in_area.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		players_in_area.erase(body)

func _physics_process(delta: float) -> void:
	camera_transition()
	
	match(players_in_area.size()):
		0: print("0")
		1: print("1")
		2: print("2")

func camera_transition():
	if !camera_player or !camera_level:
		camera_player = get_tree().get_first_node_in_group("Player Camera")
	if players_in_area.size() == 2:
		CameraTransition.transition_camera2D(camera_player, camera_level, 1)
	elif !players_in_area:
		CameraTransition.transition_camera2D(camera_level, camera_player, 1)
