extends State

@export var player : CharacterBody2D

func enter():
		await get_tree().create_timer(0.075).timeout
		player.jump_comp.apply_jump_impulse()
		player.squish_manager.light_squish()
		player.state_machine.change_state("Air Movement State")

func exit():
	pass
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	pass		

func evaluate_state():
	pass
