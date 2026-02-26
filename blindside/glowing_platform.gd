extends Platform

@export var light : PointLight2D
@export var sprite : Sprite2D
var is_glowing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_standing:
		is_glowing = true
		#sprite.self_modulate = sprite.self_modulate.lightened(0.5)
	else:
		is_glowing = false
		#sprite.self_modulate = sprite.self_modulate.darkened(0.5)
		
	manage_glow()

func manage_glow():
	if is_glowing:
		light.enabled = true
	else:
		light.enabled = false
