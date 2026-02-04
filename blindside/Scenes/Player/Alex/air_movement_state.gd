extends State

@export var player : CharacterBody2D
var variable_jump_timer : Timer
@export var gravity_normal : float = 1
@export var gravity_strong : float = 2

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
		player.gravity_comp.gravity_multiplier = gravity_normal
	else: #fast fall gravity if velocity is downward
		player.gravity_comp.gravity_multiplier = gravity_strong
	#fast fall gravity if jump key not pressed in window
	if player.is_jumping and !Input.is_action_pressed(player.input_jump): 
		player.gravity_comp.gravity_multiplier = gravity_strong

	player.gravity_comp.apply_gravity(delta)
	
	#handle jump buffering
	if Input.is_action_just_pressed(player.input_jump):
		player.buffer_jump()
	
	player.move_and_slide()

func evaluate_state():
	if player.is_on_floor():
		if !player.direction_comp.is_direction_held():
			player.state_machine.change_state("Idle State")
		else:
			player.state_machine.change_state("Ground Movement State")
