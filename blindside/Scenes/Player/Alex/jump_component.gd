class_name JumpComponent
extends Node

signal jump
@export var jump_strength : float
@export var character : CharacterBody2D

func apply_jump_impulse() -> Vector2:
	jump.emit()
	
	character.velocity.y = -jump_strength
	return character.velocity
