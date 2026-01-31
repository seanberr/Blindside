extends CharacterBody2D

@onready var velocity_comp : VelocityComponent = $"Velocity Component"
@onready var jump_comp : JumpComponent = $"Jump Component"
@onready var gravity_comp : GravityComponent = $"Gravity Component"
@onready var direction_comp : DirectionComponent = $"Direction Component"

@export var input_left : StringName
@export var input_right : StringName
@export var input_jump : StringName

@onready var state_machine : StateMachine = $"Movement FSM"

var is_jumping : bool
var variable_jump_timer : SceneTreeTimer
@export var variable_jump_window : float

func _ready() -> void:
	jump_comp.jump.connect(register_jump)
	
func _physics_process(delta: float) -> void:
	if is_on_floor():
		is_jumping = false
	
func register_jump():
	is_jumping = true
	variable_jump_timer = get_tree().create_timer(variable_jump_window)
	variable_jump_timer.timeout.connect(end_jump)
	
func end_jump():
	if !is_on_floor():
		is_jumping = false
