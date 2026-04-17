extends Node
var transition_fade_scene : PackedScene = preload("uid://bnsevia3jomlo")
var transitioning : bool = false
var transition_fade : Node2D
var transition_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition_to_scene(scene : PackedScene, player_positions : Array[Vector2]):
	if transitioning:
		return
	if transition_fade_scene.can_instantiate():
		get_tree().paused = true
		transitioning = true
		transition_fade = transition_fade_scene.instantiate()
		var transition_layer = CanvasLayer.new()
		transition_layer.layer = 999
		get_tree().root.add_child(transition_layer)
		transition_layer.add_child(transition_fade)
		transition_fade.init()
		transition_fade.transition_out()
		var out_timer : SceneTreeTimer = get_tree().create_timer(1)
		transition_scene = scene
		out_timer.timeout.connect(change_scene_with_transition.bind(scene, player_positions))
		await get_tree().create_timer(5).timeout
		transition_layer.queue_free()
		
func change_scene_with_transition(scene : PackedScene, player_positions : Array[Vector2]):
	if !scene:
		get_tree().change_scene_to_packed(transition_scene)
	else:
		get_tree().change_scene_to_packed(scene)
	PlayerLoader.spawn_positions = player_positions
		
	if is_instance_valid(transition_fade):
		get_tree().paused = false
		transition_fade.transition_in()
		var out_timer : SceneTreeTimer = get_tree().create_timer(1)
		out_timer.timeout.connect(transition_fade.queue_free)
		transitioning = false
		
