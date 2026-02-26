class_name StateMachine
extends Node
@export var initial_state : State
var current_state : State
var state_list : Dictionary = {}

func _ready():
	populate_dictionary()
	if get_parent().is_in_group("player"):
		initial_state = state_list[initial_state.to_lower()]
	current_state = initial_state
	enter_state()
	
func _physics_process(delta):
	physics_update_state(delta)
	
func _process(delta):
	update_state(delta)
	
func change_state(new_state : String):
	if new_state.to_lower() != current_state.name.to_lower():
		exit_state()
		current_state = state_list[new_state.to_lower()]
		enter_state()
	
func enter_state():
	print("Entering state: " + current_state.name.to_lower())
	current_state.enter()
	
func update_state(delta):
	current_state.update(delta)
	
func physics_update_state(delta):
	current_state.physics_update(delta)
	
func exit_state():
	print("Exiting state: " + current_state.name.to_lower())
	current_state.exit()
	
func get_state():
	return current_state
	
func populate_dictionary():
	#Loop through children and add to state list dictionary
	state_list.clear()
	for child in get_children():
		if child is State:
			state_list[child.name.to_lower()] = child
