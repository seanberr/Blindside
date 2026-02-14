extends Node2D
class_name Door

@export var is_locked : bool
var has_entered : bool = false
@export var scene_to_load : PackedScene
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
	
func _ready() -> void:
	if is_locked:
		lock()
	else:
		unlock()
			
func change_scene():
	TransitionHandler.transition_to_scene(scene_to_load)
	
func lock():
	is_locked = true
	sprite.play("Locked")
	
func unlock():
	is_locked = false
	sprite.play("Unlocked")
	
func interact():
	if !is_locked and !has_entered:
		has_entered = true
		change_scene()
