extends Node2D

# Gets the required scenes loaded to save time when starting the game
@onready var start_scene = preload("uid://7e6i77dx1mbj")
var memory_scene = preload("uid://cwpxtqk02ml5d")

@export var memory_layer : CanvasLayer

func _ready() -> void:
	AudioManager.music_manager.transition_to_track("TitleScreen")
	
	# Play the splashscreen animation if it is the first time on the main menu
	if !Global.splashscreen:
		$Splashscreen.visible = true
		$Control.visible = false
		# Wait before making the splashscreen disappear
		await get_tree().create_timer(2).timeout
		
		# Loop down from ten
		for x in range(10,0,-1):
			
			var temp : float = x
			# Decrease the alpha value
			temp = (temp / 10) - 0.015
			# Waits to create a smoother animation
			await get_tree().create_timer(0.05).timeout
			# Sets the alpha value to increase the image transparency
			$Splashscreen/Midnight.modulate.a = temp
		
		# Sets the logo to be invisible to ensure it cannot be seen
		$Splashscreen/Midnight.visible = false
		
		# Sets the game's logo to be visible
		$Splashscreen/Blindside.visible = true
		
		# Repeats the above steps to fade out the game logo
		await get_tree().create_timer(2).timeout
		for x in range(10,0,-1):
			var temp : float = x
			
			temp = (temp / 10) - 0.015
			
			await get_tree().create_timer(0.05).timeout
			
			$Splashscreen.modulate.a = temp
		
		$Control.visible = true
		$Splashscreen.visible = false

		# Set the splashscreen variable to be false so the game won't show the splashscreen again
		Global.splashscreen = true
		
	# Defaults the focus to be on the play button
	$"Control/Play".grab_focus()
	
	# Sets the state of the fullscreen checkbox
	$"CenterContainer/Settings Menu/Fullscreen".button_pressed = true if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN else false
	
	# Sets the value of the volume control sliders
	$"CenterContainer/Settings Menu/Main Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$"CenterContainer/Settings Menu/SFX Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	$"CenterContainer/Settings Menu/Music Volume".value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	
	
	
	
	
func _enter_tree() -> void:
	
	# Checks to see if the extras button should be visible
	if Global.extras_unlocked:
		$Control/Extras.visible = true

func memory_row_invisible():
	# Sets the memory rows to be invisible
	$"CenterContainer/Memories Menu/Row One".visible = false
	$"CenterContainer/Memories Menu/Row Two".visible = false

func _on_play_pressed() -> void:
	
	# Plays an audio cue
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	# Transitions the players into the starting scene
	TransitionHandler.transition_to_scene(start_scene, [Vector2(-540.0,258.0), Vector2(-455.0,258.0)])

func _on_extras_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	
	# Sets the default button to be the back button
	$"CenterContainer/Extras Menu/Back".grab_focus()
	# Sets the main buttons to be invisible
	$"Control".visible = false
	# Sets the extras menu to be visible
	$"CenterContainer/Extras Menu".visible = true
	# Sets the button background to be visible (for readability)
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
	
	# Wait for a small amount of time as the game instantly quitting can feel jarring
	await get_tree().create_timer(0.25).timeout
	# Quit the game
	get_tree().quit()



func _on_back_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	
	# Uf the memory menu was visible then the players should be sent back to the extras menu
	if $"CenterContainer/Memories Menu".visible == true:
		$"CenterContainer/Memories Menu".visible = false
		$"CenterContainer/Extras Menu".visible = true
		$"CenterContainer/Extras Menu/Back".grab_focus()
	
	# No other memu contains a submenu
	else:
		$"Control/Play".grab_focus()
		$"Control".visible = true
		
		# If the settings were visible then hide it and set the focus to the setting button
		if $"CenterContainer/Settings Menu".visible == true:
			$"CenterContainer/Settings Menu".visible = false
			$"Control/Options".grab_focus()
			$SettingsBG.visible = false
		
		# Do the same for the other two buttons
		elif $"Controls Menu".visible == true:
			$"Controls Menu".visible = false
			$"Control/Controls".grab_focus()
		
		else:
			$"CenterContainer/Extras Menu".visible = false
			$"Control/Extras".grab_focus()
			$ColorRect2.visible = false
			
func _on_fullscreen_toggled(toggled_on: bool) -> void:
	#toggles fullscreen 
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

	# Show every memory the player has collected
	for memory in Global.memories_collected:
		# For the first seven(first row)
		if memory < 8:
			# Set the related button to visible if that memory was collected
			if Global.memories_collected[memory] == true:
				$"CenterContainer/Memories Menu/Row One/".get_child(memory-1).visible = true
		# For the last seven(second row)
		else:
			# Set the related button to visible if that memory was collected
			if Global.memories_collected[memory] == true:
				$"CenterContainer/Memories Menu/Row Two/".get_child(memory-8).visible = true

func _on_concept_art_pressed() -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	
	# Load the concept art menu (done here for performance reasons)
	var conceptArt = preload("uid://clgpfnqee1vpq")
	# load into the concept art menu
	TransitionHandler.transition_to_scene(conceptArt, [Vector2.ZERO, Vector2.ZERO])
	
func _on_memory__pressed(ID: int) -> void:
	AudioManager.sfx_manager.play_sound_randomizer(["Menu_Select"] as Array[String], 0.1, 0.1, 0.0, 1.0)
	
	# Same code used in the main game to show and quit memories
	var new_memory = memory_scene.instantiate()
	new_memory.memory_length=2
	memory_layer.add_child(new_memory)
	new_memory.position = get_viewport_rect().size / 2
	new_memory.start(ID)

# Change the background dependant in which option the mouse is currently hovering over
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
