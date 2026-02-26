extends Sprite2D

@export var alpha_step : float = 0.05
@export var max_alpha : float
@export var glow_animator : AnimationPlayer

@export var enabled : bool = false
var real_position : Vector2
@export var y_offset : float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	real_position = position
	visible = true
	self_modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enabled and self_modulate.a < max_alpha:
		self_modulate.a += alpha_step * delta
	elif self_modulate.a > 0:
		self_modulate.a -= alpha_step * delta
		
	position.y = real_position.y + y_offset

func enable():
	enabled = true
	visible = true
	
func disable():
	enabled = false
