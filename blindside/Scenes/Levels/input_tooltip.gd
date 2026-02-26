extends Node

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	TooltipManager.display_tip("Control Sadie with WASD. Press E to interact.\nControl Alex with the arrow keys. Press CTRL to interact.\n", 12, Vector2(30,30))
	TooltipManager.display_tip("Press Esc to exit the game.\nPress B to toggle blindness on and off (debug).\n", 12, Vector2(30,130))
