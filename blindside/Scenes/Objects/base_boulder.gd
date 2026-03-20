extends RigidBody2D

var sadie	
var player_in_hole = false
var resetScene = preload("res://Scenes/Levels/puzzle_room_two.tscn")

func reset():
	TransitionHandler.transition_to_scene(resetScene, [Vector2(-1500, 400), Vector2(-1500, 400)])

func getPlayer():
	var players = get_tree().get_nodes_in_group("Player")
	
	for player in players:
		if player.name == ("PlayerSadie"):
			sadie = player
			
func in_place():
	print("Pushable is ", player_in_hole)
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
	print("On Entered Pushable is ", player_in_hole)
	sadie.able_to_push = false


func make_pushable():
	getPlayer()
	sadie.able_to_push = true
	player_in_hole = false
	print("On Exit Pushable is ", player_in_hole)
	
