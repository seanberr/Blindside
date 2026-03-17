extends Node2D
@export var root : Node2D
@export var platform : Node2D
@export var light : PointLight2D
@export var area : Area2D
@export var disable_timer : Timer
var is_glowing : bool = false
var max_energy : float = 1

func _ready() -> void:
	if root.corresponding_platform:
		root.corresponding_platform.glow_started.connect(enable_glow)
		root.corresponding_platform.glow_ended.connect(disable_glow)
	
func _physics_process(delta: float) -> void:
	if platform.player_standing:
		if are_players_standing():
			enable_glow()
	elif root.corresponding_platform.glow_comp.are_players_standing():
		enable_glow()
	else:
		disable_glow()

	if is_glowing:
		light.energy = lerp(light.energy, max_energy, 0.05)
	else:
		light.energy = lerp(light.energy, 0.0, 0.05)
		
	if light.energy <= 0.025:
		light.enabled = false
	
func enable_glow():
	if is_glowing == true:
		return
	light.enabled = true
	is_glowing = true
	root.start_glow()
	
func disable_glow():
	if is_glowing == false:
		return
	is_glowing = false
	root.end_glow()

func are_players_standing() -> bool:
	var bodies = area.get_overlapping_bodies()
	if !bodies:
		return false
	for body in bodies:
		if body.is_in_group("Player") and body is CharacterBody2D:
			if !body.is_on_floor():
				return false
		else:
			return false
	return true
