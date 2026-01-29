class_name DirectionComponent
extends Node

@export var sprite : Sprite2D
@export var direction_left : StringName
@export var direction_right : StringName
var direction_facing : int = 1

func update_sprite_direction(
) -> void:
	if direction_facing != 0:
		sprite.flip_h = direction_facing < 0

func update_direction() -> int:
	direction_facing = Input.get_axis(direction_left, direction_right)
	return direction_facing

func is_direction_held() -> bool:
	if Input.get_axis(direction_left, direction_right) != 0:
		return true
	return false
