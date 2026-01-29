class_name JumpComponent
extends Node

@export var jump_strength : float
@export var velocity_comp : VelocityComponent

func apply_jump_impulse() -> Vector2:
	velocity_comp.velocity.y = -jump_strength
	return velocity_comp.velocity
