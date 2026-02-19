class_name GravityComponent
extends Node

@export var character : CharacterBody2D

@onready var gravity_magnitude : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var gravity_multiplier : float = 1
@export var max_fall_speed = 1000

func apply_gravity(
	delta : float,
) -> Vector2:
	character.velocity.y += gravity_magnitude * gravity_multiplier * delta
	character.velocity.y = min(character.velocity.y, max_fall_speed)
	
	return character.velocity
