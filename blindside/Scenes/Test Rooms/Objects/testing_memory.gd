extends Node2D
@onready var interactable = $"Interactable Component"
@export var image_id : int #id of image to be displayed on collection
@export var sadie_only_id : int
@export var alex_only_id : int
@export var memory_layer : CanvasLayer
@export var is_sadie_interactable : bool = false
@export var is_alex_interactable : bool = false

var memory_scene = preload("res://Scenes/Objects/memory.tscn")

func _ready() -> void:
	interactable.is_alex_interactable = is_alex_interactable
	interactable.is_sadie_interactable = is_sadie_interactable
	interactable.set_icon_positions()

func interact():
	var new_memory = memory_scene.instantiate()
	memory_layer.add_child(new_memory)
	new_memory.position = get_viewport_rect().size / 2
		
	if is_sadie_interactable and is_alex_interactable:
		if interactable.last_id == 0:
			new_memory.start(sadie_only_id)
		else:
			new_memory.start(alex_only_id)
	else:
		new_memory.start(image_id)
