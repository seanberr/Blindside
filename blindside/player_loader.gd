extends Node

var spawn_positions : Array[Vector2] = [Vector2.ZERO, Vector2.ZERO]
var parent_scene
var player_scenes : Array[PackedScene] = [preload("res://Scenes/Player/Alex/Player_Alex.tscn"), preload("res://Scenes/Player/Sadie/Player_Sadie.tscn")]

func spawn_players():
	parent_scene = get_tree().current_scene
	var alex = player_scenes[0].instantiate()
	parent_scene.add_child(alex)
	var sadie = player_scenes[1].instantiate()
	parent_scene.add_child(sadie)
	sadie.position = spawn_positions[0]
	alex.position = spawn_positions[1]
	TransitionHandler.transitioning = false
