extends State

@export var player : CharacterBody2D
var variable_jump_timer : Timer

func enter():
	pass
	
func exit():
	pass
	
func update(delta: float):
	player.direction_comp.update_sprite_direction()
	evaluate_state()
	
func physics_update(delta: float):
	#handle velocity
	var direction : int = player.direction_comp.update_direction()
	if direction:
		player.velocity_comp.apply_air_acceleration(delta, direction)
	else:
		player.velocity_comp.apply_air_friction(delta)
	
	#apply gravity
	if player.velocity.y <= 0:
		player.gravity_comp.gravity_multiplier = 1
	else:
		player.gravity_comp.gravity_multiplier = 3
		
	if player.is_jumping and !Input.is_action_pressed(player.input_jump): 
		player.gravity_comp.gravity_multiplier = 3

		
	player.gravity_comp.apply_gravity(delta)
	
	player.velocity = player.velocity_comp.velocity
	player.move_and_slide()
	
	#handle variable jump (if player just jumped and lets go of jump button within timer, apply higher gravity

func evaluate_state():
	if player.is_on_floor():
		if !player.direction_comp.is_direction_held():
			player.state_machine.change_state("Idle State")
		else:
			player.state_machine.change_state("Ground Movement State")
