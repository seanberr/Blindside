extends Node
var transition_fade_scene : PackedScene = preload("res://Scenes/Objects/transition_fade.tscn")

var scene_to_load : PackedScene
var transition_fade : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition_to_scene(scene : PackedScene):
	if transition_fade_scene.can_instantiate():
		transition_fade = transition_fade_scene.instantiate()
		var transition_layer = CanvasLayer.new()
		transition_layer.layer = 999
		get_tree().root.add_child(transition_layer)
		transition_layer.add_child(transition_fade)
		transition_fade.init()
		transition_fade.transition_out()
		var out_timer : SceneTreeTimer = get_tree().create_timer(1)
		scene_to_load = scene
		out_timer.timeout.connect(change_scene_with_transition)
		
func change_scene_with_transition():
	get_tree().change_scene_to_packed(scene_to_load)
	if transition_fade:
		transition_fade.transition_in()
		var out_timer : SceneTreeTimer = get_tree().create_timer(1)
		out_timer.timeout.connect(transition_fade.queue_free)
