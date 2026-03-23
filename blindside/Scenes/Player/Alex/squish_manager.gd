extends Node
class_name SquishManager
@export var sprite : Node2D
@export var x_scale_original : float = 0.25
@export var y_scale_original : float = 0.25
var x_scale : float = 1
var y_scale : float = 1

var scale_warp_factor : float
var scale_warp_factor_delta : float

var scale_warp_speed : float
var scale_warp_speed_delta : float

var time_passed : float = 0
var is_squishing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().has_signal("squish"):
		get_parent().squish.connect(set_squish)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	
	if is_squishing and sprite:
		determine_scale()
		update_squish(delta)
		sprite.scale = Vector2(x_scale, y_scale)

func light_squish():
	set_squish(0.1,0.5,10)
	
func heavy_squish():
	set_squish(0.6,0.4,20)
	
func set_squish(warp_factor : float, warp_factor_delta : float, warp_speed : float,):
	time_passed = 0.0
	is_squishing = true
	scale_warp_factor = warp_factor
	scale_warp_factor_delta = warp_factor_delta
	scale_warp_speed = warp_speed

func update_squish(delta):
	scale_warp_factor = move_toward(scale_warp_factor, 0, scale_warp_factor_delta * delta)
	
	if scale_warp_factor == 0:
		is_squishing = false
	
func determine_scale():
	if is_squishing:
		x_scale = x_scale_original + (sin(time_passed * scale_warp_speed) * scale_warp_factor)
		y_scale = y_scale_original - (sin(time_passed * scale_warp_speed) * scale_warp_factor)
