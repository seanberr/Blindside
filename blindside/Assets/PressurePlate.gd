extends Node

## Sets up the class to use as a Node
class_name PressurePlate

## Allows both variables to be changed from the Inspector
@export var interactable: bool = false

## Sets a signal to control other objects
signal is_activated(value)

## If something moves onto the pressure plate
func _on_area_2d_area_entered(area: Area2D) -> void:

	is_activated.emit(true)
	
	## Debug sprite
	$"../Button".visible = false
	
## If something moves off the pressure plate
func _on_area_2d_area_exited(area: Area2D) -> void:
	
	is_activated.emit(false)
	
	## Debug sprite
	$"../Button".visible = true
