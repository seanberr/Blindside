extends Area2D
@export var image_id : int #id of image to be displayed on collection
@export var memory_layer : CanvasLayer
var memory_scene = preload("res://Scenes/Objects/memory.tscn")

## When the player goes near the memory
func _on_area_entered(area: Area2D) -> void:
	
	## Checks if the object is interactable
	if $Interactable.interactable == true:
		
		## Debug code to check functionality
		var tempColour = $Sprite2D.get_modulate() 
		tempColour.r = 1 - tempColour.r
		tempColour.g = 1 - tempColour.g
		tempColour.b = 1 - tempColour.b
		$Sprite2D.modulate = tempColour
		
		show_memory()

func show_memory():
	var new_memory = memory_scene.instantiate()
	memory_layer.add_child(new_memory)
	new_memory.position = get_viewport_rect().size / 2
	new_memory.start(image_id)
	

func _on_area_exited(area: Area2D) -> void:
	
	## Checks if the object is interactable
	if $Interactable.interactable == true:
						
		## Debug code to check functionality
		var tempColour = $Sprite2D.get_modulate() 
		tempColour.r = 1 - tempColour.r
		tempColour.g = 1 - tempColour.g
		tempColour.b = 1 - tempColour.b
		$Sprite2D.modulate = tempColour
