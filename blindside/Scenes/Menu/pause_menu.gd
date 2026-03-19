extends Control
var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Exit"):
		if is_paused:
			unpaused()
		else:
			paused()
	
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


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	
