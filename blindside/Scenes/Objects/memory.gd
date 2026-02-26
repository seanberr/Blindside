extends Sprite2D
@export var animation_player : AnimationPlayer
@export var timer : Timer
@export var memory_length : int
var memory_textures = ["res://Assets/Memory Assets/memory_placeholder.png", "res://Assets/Memory Assets/Memory_half_res_with_bg_alex_example.png","res://Assets/Memories/Memory_2_half_res.png"]

func start(id : int):
	self_modulate.a = 0
	timer.timeout.connect(end_memory)
	timer.start(memory_length)
	texture = load(memory_textures[id])
	get_tree().paused = true
	animation_player.play("Memory/Play Memory")
	
func end_memory():
	timer.timeout.disconnect(end_memory)
	animation_player.play("Memory/End Memory")
	get_tree().paused = false
	
	timer.timeout.connect(queue_free)
	timer.start(memory_length)
	
