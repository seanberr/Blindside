extends RigidBody2D

class_name BaseBoulder

var sadie	
var player_in_hole = false
var resetScene = preload("uid://rytqp8xg8cab")

func reset():
	var players = get_tree().get_nodes_in_group("Player")
	if !players: return
	for player in players:
		player.in_control = false

	TransitionHandler.transition_to_scene(resetScene, [Vector2(-1500, 400), Vector2(-1500, 400)])
	
func getPlayer():
	var players = get_tree().get_nodes_in_group("Player")
	
	for player in players:
		if player.name == ("PlayerSadie"):
			sadie = player
			
func in_place():
	if player_in_hole == true:
		reset()
		
	else:		
		## Disabled the interaction with player
		set_collision_layer_value(7, false)
		set_collision_mask_value(7, false)
		mass = 10000
		$PointLight2D.enabled = true
			

		## Enable typical static collision with player
		set_collision_layer_value(2, true)


func make_unpushable():
	getPlayer()
	player_in_hole = true
	sadie.able_to_push = false


func make_pushable():
	getPlayer()
	sadie.able_to_push = true
	player_in_hole = false
	
