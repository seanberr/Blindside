extends CharacterBody2D

@onready var velocity_comp : VelocityComponent = $"Velocity Component"
@onready var jump_comp : JumpComponent = $"Jump Component"
@onready var gravity_comp : GravityComponent = $"Gravity Component"
@onready var direction_comp : DirectionComponent = $"Direction Component"

@export var input_left : StringName
@export var input_right : StringName
@export var input_jump : StringName

@onready var state_machine : StateMachine = $"Movement FSM"

func _physics_process(delta: float) -> void:
	if is_on_floor() or is_on_ceiling():
		velocity_comp.velocity.y = 0
	if is_on_wall():
		velocity_comp.velocity.x = 0
		
