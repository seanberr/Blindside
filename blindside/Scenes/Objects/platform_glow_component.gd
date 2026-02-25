extends Node2D
@export var platform : Node2D
@export var light : PointLight2D
@export var area : Area2D
@export var disable_timer : Timer
var is_glowing : bool = false
var max_energy : float = 1

func _physics_process(delta: float) -> void:
	if platform.player_standing:
		if are_players_standing():
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
	light.enabled = true
	is_glowing = true
	
func disable_glow():
	is_glowing = false

	
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
