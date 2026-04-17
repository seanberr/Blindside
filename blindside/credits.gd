extends Node2D
var title_scene = preload("uid://bdwqpu7hq1iqu")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.music_manager.transition_to_track("Credits")
	$Camera2D.make_current()
	await get_tree().create_timer(30).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
