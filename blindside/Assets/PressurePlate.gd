extends Area2D

## Sets up the class to use as a Node
class_name PressurePlate

## Allows both variables to be changed from the Inspector
@export var interactable: bool = false

var is_activated : bool = false

## Sets a signal to control other objects
signal is_pressed()

## If something moves onto the pressure plate
func _on_area_entered(area: Area2D) -> void:
	is_activated = true
	is_pressed.emit()
	
	## Debug sprite
	$"Button".visible = false
	
## If something moves off the pressure plate
func _on_area_exited(area: Area2D) -> void:
	if !get_overlapping_areas():
		is_activated = false
		## Debug sprite
		$"Button".visible = true
