class_name VelocityComponent
extends Node

@export var character : CharacterBody2D

@export var max_speed: float = 1000
@export var ground_acceleration_time : float = 0.1
@onready var ground_acceleration : float = max_speed / ground_acceleration_time
@export var air_acceleration_time : float = 0.1
@onready var air_acceleration : float = max_speed / air_acceleration_time
@export var ground_friction_time : float = 0.5
@onready var ground_friction : float = max_speed / ground_friction_time
@export var air_friction_time : float = 0.1
@onready var air_friction : float = max_speed / air_friction_time
			
func recalculate_values():
	ground_acceleration = max_speed / ground_acceleration_time
	air_acceleration = max_speed / air_acceleration_time
	ground_friction = max_speed / ground_friction_time
	air_friction = max_speed / air_friction_time
	
func apply_acceleration(
	delta : float,
	direction : float,
	acceleration : float,
) -> Vector2:
	direction = clamp(direction, -1.0, 1.0)
		
	character.velocity.x += acceleration * direction * delta
	
	if character.velocity.x > max_speed:
		character.velocity.x = min(character.velocity.x, max_speed)
	elif character.velocity.x < -max_speed:
		character.velocity.x = max(character.velocity.x, -max_speed)
		
	return character.velocity
	
func apply_ground_acceleration(
	delta : float,
	direction : float,
) -> Vector2:
	return apply_acceleration(delta, direction, ground_acceleration)
	
func apply_air_acceleration(
	delta : float,
	direction : float,
) -> Vector2:
	return apply_acceleration(delta, direction, air_acceleration)
	
func apply_friction(
	delta : float,
	friction: float,
) -> Vector2:
	if character.velocity.x == 0:
		return character.velocity
	elif character.velocity.x < 0:
		character.velocity.x += friction * delta
		if character.velocity.x > 0: #prevent friction overshooting 0
			character.velocity.x = 0
	elif character.velocity.x > 0:
		character.velocity.x -= friction * delta
		if character.velocity.x < 0:
			character.velocity.x = 0
	
	return character.velocity
func apply_ground_friction(
	delta : float,
) -> Vector2:
	return apply_friction(delta, ground_friction)
	
func apply_air_friction(
	delta : float,
) -> Vector2:
	return apply_friction(delta, air_friction)
