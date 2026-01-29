extends Area2D

func _ready():
	add_to_group("Interactable")

@export var interactable: bool = false
