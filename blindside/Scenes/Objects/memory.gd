extends Sprite2D
@export var animation_player : AnimationPlayer
@export var timer : Timer
@export var memory_length : int
var memory_ended : bool = false
var memory_endable : bool = false
var memory_textures = ["uid://c0wgbjhgfelgw", 
"uid://b0w2nj7tlapbk",
"uid://cclfbeatgyc7v",
"uid://bgu8kddr2xont",
"uid://xj6weorafexr",
"uid://dlxailk3mgf5",
"uid://dl5qmrswwexri",
"uid://b8giyahoseggc",
"uid://dx8n0yjqkb771",
"uid://c61tp7g8crcb4",
"uid://b6bjf7xa7r4y6",
"uid://chronnsem5dds",
"uid://ccera5gq5hlfj",
"uid://cplbvvlphvp",
"uid://bnmlppuerqs7m"]

func start(id : int):
	self_modulate.a = 0
	#timer.timeout.connect(end_memory)
	#timer.start(memory_length)
	texture = load(memory_textures[id])
	if !texture:
		texture = load("uid://cuc8su8n6dxth")
	get_tree().paused = true
	animation_player.play("Memory/Play Memory")
	
func _physics_process(delta: float) -> void:
	get_tree().create_timer(0.5).timeout.connect(set_memory_endable)
	if Input.is_action_just_pressed("Player1_Interact") or Input.is_action_just_pressed("Player2_Interact"):
		if memory_ended == false and memory_endable == true:
			memory_ended = true
			end_memory()
			
func set_memory_endable():
	memory_endable = true
func end_memory():
	#timer.timeout.disconnect(end_memory)
	animation_player.play("Memory/End Memory")
	get_tree().paused = false
	timer.timeout.connect(queue_free)
	timer.start(1)
	
 
