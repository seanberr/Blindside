extends RigidBody2D
class_name BaseBoulder

# Initialise the player to not be in an indentation 
var player_in_hole = false
# Loads the scene so resets are faster
var reset_scene = preload("uid://rytqp8xg8cab")

func reset():
	# Gets the player
	var players = get_tree().get_nodes_in_group("Player")
	# Catches any errors
	if !players: return
	# Set each player to not be control
	for player in players:
		player.in_control = false
	
	# Reset the scene
	TransitionHandler.transition_to_scene(reset_scene, [Vector2(-1500, 400), Vector2(-1500, 400)])
	
func get_player(push : bool, player : String):
	# Gets the players
	var players = get_tree().get_nodes_in_group("Player")
	
	# Sets the character to either be able or not able to push boulders based on the input variable
	for character in players:
		if character.name == player:
			character.able_to_push = push
			
func in_place():
	# If the player is on the boulder when it is in the correct place then reset the scene
	if player_in_hole == true:
		reset()
		
	# Otherwise:
	else:		
		# Disable the pushing interaction with players
		set_collision_layer_value(7, false)
		set_collision_mask_value(7, false)
		
		# Set the boulder to be functionally immovable
		mass = 10000
		
		# Enable the light
		$PointLight2D.enabled = true
			
		# Enable typical static collision with players
		set_collision_layer_value(2, true)


func make_unpushable(player: String):
	# Calls the get_player function and sets them unable to push the boulders
	get_player(false, player)
	# Sets the internal variable so the scene knows the player is in the hole
	player_in_hole = true
	

func make_pushable(player: String):
	# Calls the get_player function and sets them able to push the boulders
	get_player(true, player)
	# Sets the internal variable so the scene knows the player is in not the hole
	player_in_hole = false
	
func end_scene():
	# When the scene needs to end
	# Get the players
	var players = get_tree().get_nodes_in_group("Player")
	# Set them unable to push boulders
	for character in players:
		character.able_to_push = false
