extends Node2D
class_name Door

@export var is_locked : bool
var has_entered : bool = false
@export var scene_to_load : PackedScene
@export var player_coords : Array[Vector2]
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var has_fog : bool
@onready var fog_sprite : Sprite2D = $Fog
@onready var alpha_animator = $AlphaAnimator

func _ready() -> void:
	if is_locked:
		lock()
	else:
		unlock()
		
	if !has_fog and fog_sprite:
		fog_sprite.visible = false
		

func change_scene():
	TransitionHandler.transition_to_scene(scene_to_load, player_coords)
	
func lock():
	is_locked = true
	sprite.play("Locked")
	
func unlock():
	is_locked = false
	sprite.play("Unlocked")
	if fog_sprite:
		alpha_animator.play("Clear")
	
func interact():
	if !is_locked and !has_entered:
		has_entered = true
		change_scene()
