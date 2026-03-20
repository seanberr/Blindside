extends Control
var is_paused = false
var able_to_pause = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if able_to_pause:
		if Input.is_action_just_pressed("Exit"):
			if is_paused:
				unpaused()
			else:
				if !get_tree().paused:
					paused()
	
	if $"../..".in_control:
		if !able_to_pause:		
			make_pausable()
	else:
		if able_to_pause:	
			make_unpausable()
	
func paused():
		$CanvasLayer.visible = true
		get_tree().paused = true
		is_paused = true
		$CanvasLayer/VBoxContainer/Unpause.grab_focus()

func unpaused():
	is_paused = false
	$CanvasLayer.visible = false
	get_tree().paused = false


func _on_unpause_pressed() -> void:
	unpaused()

func _on_quit_pressed() -> void:
	get_tree().quit()

func make_unpausable():
	able_to_pause = false
	
func make_pausable():
	able_to_pause = true

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	
