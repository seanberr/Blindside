extends Sprite2D
@export var animation_player : AnimationPlayer
@export var timer : Timer
@export var memory_length : int
var memory_textures = ["res://Assets/Memories/Memory Assets/memory_placeholder.png", 
"res://Assets/Memories/memory_1.png",
"res://Assets/Memories/memory_2.png",
"res://Assets/Memories/memory_3_PH.png",
"res://Assets/Memories/memory_4_PH.png",
"res://Assets/Memories/memory_5_PH.png",
"res://Assets/Memories/memory_6_PH.png",
"res://Assets/Memories/memory_7_PH.png",
"res://Assets/Memories/memory_8_PH.png",
"res://Assets/Memories/memory_9_PH.png",
"res://Assets/Memories/memory_10_PH.png",
"res://Assets/Memories/memory_11_PH.png",
"res://Assets/Memories/memory_12_PH.png",
"res://Assets/Memories/memory_13_PH.png",
"res://Assets/Memories/memory_14_PH.png"]

func start(id : int):
	self_modulate.a = 0
	timer.timeout.connect(end_memory)
	timer.start(memory_length)
	texture = load(memory_textures[id])
	if !texture:
		texture = load("res://Assets/Debug/error.png")
	get_tree().paused = true
	animation_player.play("Memory/Play Memory")
	
func end_memory():
	timer.timeout.disconnect(end_memory)
	animation_player.play("Memory/End Memory")
	get_tree().paused = false
	
	timer.timeout.connect(queue_free)
	timer.start(memory_length)
	
 
