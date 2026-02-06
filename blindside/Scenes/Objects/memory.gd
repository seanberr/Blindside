extends Sprite2D
@export var animation_player : AnimationPlayer
@export var timer : Timer
@export var memory_length : int
var memory_textures = ["res://Assets/Memory Assets/memory_placeholder.png"]

func start(id : int):
	timer.timeout.connect(end_memory)
	timer.start(memory_length)
	texture = load(memory_textures[id])
	get_tree().paused = true
	animation_player.play("Memory/Play Memory")
	
func end_memory():
	animation_player.play("Memory/End Memory")
	get_tree().paused = false
	
	timer.timeout.connect(queue_free)
	timer.start(memory_length)
	
