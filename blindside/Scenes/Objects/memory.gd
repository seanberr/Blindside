extends Sprite2D
@export var animation_player : AnimationPlayer
@export var timer : Timer
@export var memory_length : int
var memory_ended : bool = false
var memory_endable : bool = false
var memory_textures = ["uid://c0wgbjhgfelgw", 
"uid://35g645ejforj",
"uid://cfvv6a15da5hj",
"uid://4whdiacpsb82",
"uid://cn2an080micv5",
"uid://cmhr8ke27k8se",
"uid://cvmgqi3by2bo4",
"uid://d1tcq6puc1fda",
"uid://cqv2jpxm6y47o",
"uid://c0a608ccpqp4a",
"uid://dljd3dqlac6se",
"uid://cvmg6aa6n5a5o",
"uid://bpe8t8iomvur1",
"uid://buvvyk4ui0803",
"uid://bysyi04r8cass",]

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
	
 
