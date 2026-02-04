extends Node

## Sets up the class to use as a Node
class_name Interactable

func _ready():
	add_to_group("Interactable")

## Allows both variables to be changed from the Inspector
@export var interactable: bool = false
