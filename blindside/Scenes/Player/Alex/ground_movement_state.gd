extends State

@export var player : CharacterBody2D

func enter():
	player.sprite.frame_changed.connect(handle_footstep)
	
func exit():
	player.sprite.frame_changed.disconnect(handle_footstep)
	
func handle_footstep():
	if player.id == 0:
		if player.sprite.frame == 0 or player.sprite.frame == 4:
			player.footstep.emit()
	else:
		if player.sprite.frame == 0 or player.sprite.frame == 12:
			player.footstep.emit()
	
func update(delta: float):
	if player.in_control:
		player.direction_comp.update_sprite_direction()
	evaluate_state()
	
func physics_update(delta: float):
	if player.in_control:
		#handle velocity
		var direction : int = player.direction_comp.update_direction()
		if direction and player.in_control:
			player.velocity_comp.apply_ground_acceleration(delta, direction)
		else:
			player.velocity_comp.apply_ground_friction(delta)

		#handle jump
		if Input.is_action_just_pressed(player.input_jump):
			player.state_machine.change_state("Prepare To Jump State")
		
	player.move_and_slide()

func evaluate_state():
	if player.is_on_floor():
		if !player.direction_comp.is_direction_held():
			player.state_machine.change_state("Idle State")
	else:
		player.state_machine.change_state("Air Movement State")
