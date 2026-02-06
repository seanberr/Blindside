extends CharacterBody2D

@onready var velocity_comp : VelocityComponent = $"Velocity Component"
@onready var jump_comp : JumpComponent = $"Jump Component"
@onready var gravity_comp : GravityComponent = $"Gravity Component"
@onready var direction_comp : DirectionComponent = $"Direction Component"

@export var input_left : StringName
@export var input_right : StringName
@export var input_jump : StringName

@onready var state_machine : StateMachine = $"Movement FSM"

##
var NEAR_OBJECT

#variable jump values
var is_jumping : bool
var variable_jump_timer : SceneTreeTimer
@export var variable_jump_window : float = 0.2

#jump buffer values
var is_jump_queued : bool = false
var jump_buffer_timer : SceneTreeTimer
@export var jump_buffer_window : float = 0.2

func _ready() -> void:
	jump_comp.jump.connect(begin_variable_jump)
	
func _physics_process(delta: float) -> void:
	if is_on_floor():
		is_jumping = false
		if is_jump_queued:
			is_jump_queued = false
			jump_comp.apply_jump_impulse()

	# Handles interacting with objects
	if Input.is_action_just_pressed("ui_accept"):
						
			## Checks if there is an object nearby
			if NEAR_OBJECT != null:
			
			## Checks if the nearest object is interactable
				# Checks for the Interactable group
				if NEAR_OBJECT.is_in_group("Interactable"):
						
					if NEAR_OBJECT.get_node("Interactable").interactable == true:
							
							## Debug code to check functionality
							position = Vector2(0,0)
				
				## Checks for the Memory group
				elif NEAR_OBJECT.is_in_group("Memory"):
					
					## Checks if the object is interactable
					if NEAR_OBJECT.get_node("Interactable").interactable == true:
						
						## Debug code to check functionality
						var tempColour = $Sprite2D.get_modulate() 
						tempColour.r = 1 - tempColour.r
						tempColour.g = 1 - tempColour.g
						tempColour.b = 1 - tempColour.b
						$Sprite2D.modulate = tempColour

func _on_interacting_area_area_entered(area: Area2D) -> void:
	
	# When overlapping an area with collision layer 5
	
	# Sets a reference for that object to the nearest object
	NEAR_OBJECT = area
	

func _on_interacting_area_area_exited(area: Area2D) -> void:
			
	# Removes the reference to the closest object
	NEAR_OBJECT = null

	
func buffer_jump():
	is_jump_queued = true
	jump_buffer_timer = get_tree().create_timer(jump_buffer_window)
	jump_buffer_timer.timeout.connect(end_jump_buffer)
	
func end_jump_buffer():
	is_jump_queued = false
	
func begin_variable_jump():
	is_jumping = true
	variable_jump_timer = get_tree().create_timer(variable_jump_window)
	variable_jump_timer.timeout.connect(end_variable_jump)
	
func end_variable_jump():
	if !is_on_floor():
		is_jumping = false
