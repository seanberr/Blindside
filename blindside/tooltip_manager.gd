extends Node
var tip_layer : CanvasLayer
var tooltip_scene : PackedScene = preload("res://Scenes/Objects/tooltip.tscn")

func _enter_tree() -> void:
	tip_layer = CanvasLayer.new()
	tip_layer.layer = 9999
	get_tree().root.add_child(tip_layer)
	
func create_layer():
	tip_layer = CanvasLayer.new()
	tip_layer.layer = 9999
	get_tree().root.add_child(tip_layer)
	
func display_tip(text: String, duration: float, location : Vector2):
	if !is_instance_valid(tip_layer):
		return
	if !tooltip_scene.can_instantiate():
		return
		
	create_layer()
	var tooltip = tooltip_scene.instantiate()
	tooltip.label.self_modulate.a = 0
	tip_layer.add_child(tooltip)
	tooltip.set_text(text)
	tooltip.position = location
	tooltip.display(duration)
	
