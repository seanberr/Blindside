extends Control
var is_paused = false
var able_to_pause = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# If the player is currenly allowed to pause
	if able_to_pause:
		# Check if they have pressed the pause button
		if Input.is_action_just_pressed("Exit"):
			# Unpause the game if it is already paused
			if is_paused:
				unpaused()
			# Otherwise pause the game
			else:
				if !get_tree().paused:
					paused()
	
	# If the player is in control then allow them to pause if it was previous disabled
	if $"../..".in_control:
		if !able_to_pause:		
			make_pausable()
	# If the player is not in control then disallow them to pause if they were previously allowed
	else:
		if able_to_pause:	
			make_unpausable()
	
func paused():
		# Sets the pause menu to be visible
		$CanvasLayer.visible = true
		# Pauses the game
		get_tree().paused = true
		# Sets the internal variable so the scene knows it's paused
		is_paused = true
		# Grab the focus for the pause button
		$CanvasLayer/VBoxContainer/Unpause.grab_focus()

func unpaused():
	# Set the interval variable so the scene knows it's not paused
	is_paused = false
	# Sets the pause screen not to be visible
	$CanvasLayer.visible = false
	# Unpauses the game
	get_tree().paused = false


func _on_unpause_pressed() -> void:
	unpaused()

func _on_quit_pressed() -> void:
	# Quit the game
	get_tree().quit()

func make_unpausable():
	able_to_pause = false
	
func make_pausable():
	able_to_pause = true

func _on_main_menu_pressed() -> void:
	# Unpauses the game
	get_tree().paused = false
	# Sends the player to the main menu
	get_tree().change_scene_to_file("uid://bdwqpu7hq1iqu")
	
