extends Node

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	TooltipManager.display_tip("Control Sadie with WASD. Press E to interact.\nControl Alex with the arrow keys. Press CTRL to interact.\n", 9, Vector2(30,30))
	await get_tree().create_timer(9).timeout
	TooltipManager.display_tip("Press Esc to exit the game.\nPress B to toggle blindness on and off.\n", 9, Vector2(30,30))
