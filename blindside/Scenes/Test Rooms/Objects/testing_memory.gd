extends Area2D

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


func _on_area_exited(area: Area2D) -> void:
	
	## Checks if the object is interactable
	if $Interactable.interactable == true:
						
		## Debug code to check functionality
		var tempColour = $Sprite2D.get_modulate() 
		tempColour.r = 1 - tempColour.r
		tempColour.g = 1 - tempColour.g
		tempColour.b = 1 - tempColour.b
		$Sprite2D.modulate = tempColour
