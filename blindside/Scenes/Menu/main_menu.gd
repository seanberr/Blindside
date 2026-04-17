extends Node2D

@onready var start_scene = preload("uid://7e6i77dx1mbj")
var memory_scene = preload("uid://cwpxtqk02ml5d")
@export var memory_layer : CanvasLayer

func _ready() -> void:
	AudioManager.music_manager.transition_to_track("TitleScreen")
	Global.splashscreen = false
	if !Global.splashscreen:
		$Splashscreen.visible = true
		await get_tree().create_timer(2).timeout
		for x in range(10,0,-1):
			var temp : float = x
			temp = (temp / 10) - 0.015
			print(temp)	
			await get_tree().create_timer(0.05).timeout
			$Splashscreen.modulate.a = temp
		
		$Splashscreen.visible = false
		Global.splashscreen = true
	$"Control/Play".grab_focus()
	$"CenterContainer/Settings Menu/Fullscreen".button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN else false
	$"CenterContainer/Settings Menu/Main Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$"CenterContainer/Settings Menu/SFX Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	$"CenterContainer/Settings Menu/Music Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	
	#$Splashscreen.visible = false
	
	
	
func _enter_tree() -> void:
	if Global.extrasUnlocked:
		$Control/Extras.visible = true

func memory_row_invisible():
	$"CenterContainer/Memories Menu/Row One".visible = false
	$"CenterContainer/Memories Menu/Row Two".visible = false

func _on_play_pressed() -> void:
	
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	TransitionHandler.transition_to_scene(start_scene, [Vector2(-540.0,258.0), Vector2(-455.0,258.0)])

func _on_extras_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	$"CenterContainer/Extras Menu/Back".grab_focus()
	$"Control".visible = false
	$"CenterContainer/Extras Menu".visible = true
	$ColorRect2.visible = true

func _on_options_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	
	$"CenterContainer/Settings Menu/Back".grab_focus()
	$"Control".visible = false
	$"CenterContainer/Settings Menu".visible = true
	$SettingsBG.visible = true
func _on_controls_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	$"Controls Menu/Control Screen/HBoxContainer/Back".grab_focus()
	$"CenterContainer/Main Buttons".visible = false
	$"Controls Menu".visible = true

func _on_quit_pressed() -> void:
	
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()



func _on_back_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	if $"CenterContainer/Memories Menu".visible == true:
		$"CenterContainer/Memories Menu".visible = false
		$"CenterContainer/Extras Menu".visible = true
		$"CenterContainer/Extras Menu/Back".grab_focus()
	
	elif $"CenterContainer/Concept Art Menu".visible == true:
		$"CenterContainer/Concept Art Menu".visible = false
		$"CenterContainer/Extras Menu".visible = true
		$"CenterContainer/Extras Menu/Back".grab_focus()
	
	else:
		$"Control/Play".grab_focus()
		$"Control".visible = true
		
		if $"CenterContainer/Settings Menu".visible == true:
			$"CenterContainer/Settings Menu".visible = false
			$"Control/Options".grab_focus()
			$SettingsBG.visible = false
		elif $"Controls Menu".visible == true:
			$"Controls Menu".visible = false
			$"Control/Controls".grab_focus()
		
		else:
			$"CenterContainer/Extras Menu".visible = false
			$"Control/Extras".grab_focus()
			$ColorRect2.visible = false
			
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


func _on_memories_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	$"CenterContainer/Memories Menu/Back".grab_focus()
	$"CenterContainer/Memories Menu".visible = true
	$"CenterContainer/Extras Menu".visible = false

	for memory in Global.memories_collected:
		if memory < 8:
			if Global.memories_collected[memory] == true:
				$"CenterContainer/Memories Menu/Row One/".get_child(memory-1).visible = true
		else:
			if Global.memories_collected[memory] == true:
				$"CenterContainer/Memories Menu/Row Two/".get_child(memory-8).visible = true

func _on_concept_art_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	var conceptArt = preload("uid://clgpfnqee1vpq")
	TransitionHandler.transition_to_scene(conceptArt, [Vector2.ZERO, Vector2.ZERO])
	#$"CenterContainer/Concept Art Menu/Back".grab_focus()
	#$"CenterContainer/Concept Art Menu".visible = true
	#$"CenterContainer/Extras Menu".visible = false

func _on_memory__pressed(ID: int) -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	var new_memory = memory_scene.instantiate()
	new_memory.memory_length=2
	memory_layer.add_child(new_memory)
	new_memory.position = get_viewport_rect().size / 2
	new_memory.start(ID)


func _on_play_mouse_entered() -> void:
	$PlayBG.visible = true


func _on_play_mouse_exited() -> void:
	$PlayBG.visible = false


func _on_options_mouse_entered() -> void:
	$SettingsBG.visible = true

func _on_options_mouse_exited() -> void:
	$SettingsBG.visible = false


func _on_quit_mouse_entered() -> void:
	$ExitBG.visible = true


func _on_quit_mouse_exited() -> void:
	$ExitBG.visible = false


func _on_controls_mouse_entered() -> void:
	$ControlsBG.visible = true


func _on_controls_mouse_exited() -> void:
	$ControlsBG.visible = false
