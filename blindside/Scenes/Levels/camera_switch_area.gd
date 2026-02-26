extends PlayerDetectionArea
@export var camera_level : Camera2D
@onready var camera_player = get_tree().get_first_node_in_group("Player Camera")

func _physics_process(delta: float) -> void:
	if !camera_player or !camera_level:
		return
	if players_in_area.size() == 2:
		CameraTransition.transition_camera2D(camera_player, camera_level, 1)
	elif !players_in_area:
		CameraTransition.transition_camera2D(camera_level, camera_player, 1)
