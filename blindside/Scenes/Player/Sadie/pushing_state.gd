extends "res://Scenes/Player/Alex/state.gd"

@export var player : CharacterBody2D

func enter():
	## Allows the player to push objects on the collision mask 7
	player.set_collision_mask_value(7, true)
	
			
func exit():
	## Stops the player from pushing objects on the collision mask 7
	player.set_collision_mask_value(7, false)

func update(delta: float):
	player.direction_comp.update_sprite_direction()
	evaluate_state()
	
func physics_update(delta: float):
	
	#handle velocity
	var direction : int = player.direction_comp.update_direction()
	if direction:
		player.velocity_comp.apply_ground_acceleration(delta, direction)
	else:
		player.velocity_comp.apply_ground_friction(delta)

	
	player.move_and_slide()
	
	## Apply a force to relevant objects
	for i in player.get_slide_collision_count():
		var c = player.get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * player.push_force)	
			

func evaluate_state():
	if !player.is_on_floor():
		player.state_machine.change_state("Air Movement State")
