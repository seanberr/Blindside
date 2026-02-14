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
