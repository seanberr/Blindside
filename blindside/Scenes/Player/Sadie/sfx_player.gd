extends Node
@export var player : CharacterBody2D
@export var tile_handler : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player.jump_comp.jump.connect(on_jump)
	player.footstep.connect(on_footstep)


func on_jump():
	if player.id == 0:
		play_sadie_jump()
	else:
		play_alex_jump()

func on_footstep():
	if player.id == 0:
		play_sadie_footstep()
	else:
		play_alex_footstep()

func play_sadie_jump():
	match(tile_handler.get_tile_below()):
		"rock":
			AudioManager.sfx_manager.play_sound_randomizer(["Sadie_Jump_Rock"] as Array[String], 0.0, 0.1, 0.0, 1.0)
		"grass":
			AudioManager.sfx_manager.play_sound_randomizer(["Sadie_Jump_Grass"] as Array[String], 0.0, 0.1, 0.0, 1.0)
		"null":
			AudioManager.sfx_manager.play_sound_randomizer(["Sadie_Jump_Grass"] as Array[String], 0.0, 0.1, 0.0, 1.0)
			
func play_alex_jump():
	match(tile_handler.get_tile_below()):
		"rock":
			AudioManager.sfx_manager.play_sound_randomizer(["Alex_Jump_Rock"] as Array[String], 0.0, 0.1, 0.0, 1.0)
		"grass":
			AudioManager.sfx_manager.play_sound_randomizer(["Alex_Jump_Grass"] as Array[String], 0.0, 0.1, 0.0, 1.0)
		"null":
			AudioManager.sfx_manager.play_sound_randomizer(["Alex_Jump_Grass"] as Array[String], 0.0, 0.1, 0.0, 1.0)
			
func play_sadie_footstep():
	match(tile_handler.get_tile_below()):
		"rock":
			AudioManager.sfx_manager.play_sound_randomizer(["Sadie_Walk_Rock"] as Array[String], 0.0, 0.1, -10.0, 1.0)
		"grass":
			AudioManager.sfx_manager.play_sound_randomizer(["Sadie_Walk_Grass"] as Array[String], 0.0, 0.1, -10.0, 1.0)
		"null":
			AudioManager.sfx_manager.play_sound_randomizer(["Sadie_Walk_Grass"] as Array[String], 0.0, 0.1, -10.0, 1.0)
			
func play_alex_footstep():
	match(tile_handler.get_tile_below()):
		"rock":
			AudioManager.sfx_manager.play_sound_randomizer(["Sadie_Walk_Rock"] as Array[String], 0.0, 0.1, -10.0, 1.0)
		"grass":
			AudioManager.sfx_manager.play_sound_randomizer(["Alex_Walk_Grass"] as Array[String], 0.0, 0.1, -10.0, 1.0)
		"null":
			AudioManager.sfx_manager.play_sound_randomizer(["Alex_Walk_Grass"] as Array[String], 0.0, 0.1, -10.0, 1.0)
