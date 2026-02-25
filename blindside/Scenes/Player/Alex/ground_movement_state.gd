extends State

@export var player : CharacterBody2D

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
	if direction and player.in_control:
		player.velocity_comp.apply_ground_acceleration(delta, direction)
	else:
		player.velocity_comp.apply_ground_friction(delta)

	#handle jump
	if Input.is_action_just_pressed(player.input_jump) and player.in_control:
		player.jump_comp.apply_jump_impulse()
		player.state_machine.change_state("Air Movement State")
	
	player.move_and_slide()

func evaluate_state():
	if player.is_on_floor():
		if !player.direction_comp.is_direction_held():
			player.state_machine.change_state("Idle State")
	else:
		player.state_machine.change_state("Air Movement State")
