extends Level


func _ready() -> void:
	PlayerLoader.players_spawned.connect(disable_camera_parameters)
	super._ready()

func disable_camera_parameters(): #must change the camera for this room because the camera switching doesn't account for drag or smoothing
	var players = get_tree().get_nodes_in_group("Player")
	var sadie : CharacterBody2D
	for player in players:
		if player.name == "PlayerSadie":
			sadie = player
	var sadie_camera : Camera2D = sadie.get_node("MainCamera")
	if sadie_camera:
		sadie_camera.drag_horizontal_enabled = false
		sadie_camera.drag_vertical_enabled = false
		sadie_camera.position_smoothing_enabled = false
