extends Node2D

## Sets up the class to use as a Node
class_name Interactable

@export var parent : Node = get_parent()
@export var is_sadie_interactable : bool = false
@export var is_alex_interactable : bool = false
@export var interaction_area : Area2D
var last_id : int = 0

func interact(id : int):
	last_id = id
	if id == 1 and !is_sadie_interactable:
		return
	if id == 2 and !is_alex_interactable:
		return
	if parent.has_method("interact"):
		parent.interact()
