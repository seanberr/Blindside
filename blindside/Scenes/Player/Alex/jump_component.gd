class_name JumpComponent
extends Node

signal jump
@export var jump_strength : float
@export var velocity_comp : VelocityComponent

func apply_jump_impulse() -> Vector2:
	jump.emit()
	
	velocity_comp.velocity.y = -jump_strength
	return velocity_comp.velocity
