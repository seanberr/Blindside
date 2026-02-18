extends Node2D
@export var image_id : int #id of image to be displayed on collection
@export var memory_layer : CanvasLayer
var memory_scene = preload("res://Scenes/Objects/memory.tscn")

func interact():
	var new_memory = memory_scene.instantiate()
	memory_layer.add_child(new_memory)
	new_memory.position = get_viewport_rect().size / 2
	new_memory.start(image_id)
