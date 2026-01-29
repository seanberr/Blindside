class_name GravityComponent
extends Node

@export var velocity_comp : VelocityComponent

@onready var gravity_magnitude : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var gravity_multiplier : float = 1

func apply_gravity(
	delta : float,
) -> Vector2:
	velocity_comp.velocity.y += gravity_magnitude * gravity_multiplier * delta
	
	return velocity_comp.velocity
