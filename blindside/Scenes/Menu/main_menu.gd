extends Node2D

func _ready() -> void:
	$"CenterContainer/Main Buttons/Play".grab_focus()
	$"CenterContainer/Settings Menu/Fullscreen".button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN else false
	$"CenterContainer/Settings Menu/Main Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$"CenterContainer/Settings Menu/SFX Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	$"CenterContainer/Settings Menu/Music Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(str("res://Scenes/Levels/puzzle_room_one.tscn"))


func _on_extras_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	$"CenterContainer/Settings Menu/Back".grab_focus()
	$"CenterContainer/Main Buttons".visible = false
	$"CenterContainer/Settings Menu".visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	$"CenterContainer/Main Buttons/Play".grab_focus()
	$"CenterContainer/Main Buttons".visible = true
	$"CenterContainer/Settings Menu".visible = false


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func _on_main_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)


func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
