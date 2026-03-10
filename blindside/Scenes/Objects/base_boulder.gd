extends RigidBody2D

var sadie	
var pushable = true

func reset():
	get_tree().change_scene_to_file(str("res://Scenes/Levels/puzzle_room_two.tscn"))

func getPlayer():
	var players = get_tree().get_nodes_in_group("Player")
	
	for player in players:
		if player.name == ("PlayerSadie"):
			sadie = player

func in_place():
	if pushable == false:
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
	
	pushable = false
	sadie.able_to_push = false


func make_pushable():
	getPlayer()
	sadie.able_to_push = true
	pushable = true
