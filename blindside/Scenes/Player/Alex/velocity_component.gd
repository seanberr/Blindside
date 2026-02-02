class_name VelocityComponent
extends Node

@export var character : CharacterBody2D

@export var max_speed: float = 1000
@export var ground_acceleration_time : float = 0.1
@onready var ground_acceleration : float = max_speed / ground_acceleration_time
@export var air_acceleration_time : float = 0.0
@onready var air_acceleration : float = max_speed / air_acceleration_time
@export var ground_friction_time : float = 0.5
@onready var ground_friction : float = max_speed / ground_friction_time
@export var air_friction_time : float = 0.0
@onready var air_friction : float = max_speed / air_friction_time

var velocity : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if character:
		if character.is_on_floor() or character.is_on_ceiling():
			velocity.y = 0
		if character.is_on_wall() and !character.is_on_floor():
			velocity.x = 0
func apply_acceleration(
	delta : float,
	direction : float,
	acceleration : float,
) -> Vector2:
	direction = clamp(direction, -1.0, 1.0)
		
	velocity.x += acceleration * direction * delta
	
	if velocity.x > max_speed:
		velocity.x = min(velocity.x, max_speed)
	elif velocity.x < -max_speed:
		velocity.x = max(velocity.x, -max_speed)
		
	return velocity
	
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
	if velocity.x == 0:
		return velocity
	elif velocity.x < 0:
		velocity.x += friction * delta
		if velocity.x > 0: #prevent friction overshooting 0
			velocity.x = 0
	elif velocity.x > 0:
		velocity.x -= friction * delta
		if velocity.x < 0:
			velocity.x = 0
	
	return velocity
func apply_ground_friction(
	delta : float,
) -> Vector2:
	return apply_friction(delta, ground_friction)
	
func apply_air_friction(
	delta : float,
) -> Vector2:
	return apply_friction(delta, air_friction)
