extends State

@onready var player : CharacterBody2D = get_node("../..")

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

	#handle jump
	if Input.is_action_pressed(player.input_jump):
		pass
	
	#apply gravity
	if player.velocity.y <= 0:
		player.gravity_comp.gravity_multiplier = 1
	else: 
		player.gravity_comp.gravity_multiplier = 2
	player.gravity_comp.apply_gravity(delta)
	
	player.velocity = player.velocity_comp.velocity
	player.move_and_slide()

func evaluate_state():
	if player.is_on_floor():
		if !player.direction_comp.is_direction_held():
			player.state_machine.change_state("Idle State")
		else:
			player.state_machine.change_state("Ground Movement State")
