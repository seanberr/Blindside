extends Node
@export var grass_jump_string : String
@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player.jump_comp.jump.connect(on_jump)


func on_jump():
	AudioManager.sfx_manager.play_sound_randomizer([grass_jump_string] as Array[String], 0.1, 0.2, -15.0, 1.0)
