extends Node
var transitioning : bool = false
@onready var transition_camera : Camera2D = $Camera2D
var from_camera : Camera2D
var to_camera : Camera2D
var time_passed : float
var current_lerp

func transition_camera2D(from: Camera2D, to: Camera2D, lerp: float) -> void:
	time_passed = 0
	current_lerp = lerp
	from_camera = from
	to_camera = to
	
	if !transitioning:
		transition_camera.global_position = from.global_position
		transition_camera.zoom = from.zoom
	
	transitioning = true
	transition_camera.enabled = true
	transition_camera.make_current()
	
func _process(delta: float) -> void:
	if transitioning:
		transition_update(delta)

func transition_update(delta: float):
	if current_lerp < 1:
		current_lerp += current_lerp / 10
		current_lerp = min(current_lerp, 1)
	time_passed += delta
	transition_camera.offset = lerp(transition_camera.offset, to_camera.offset, current_lerp)
	transition_camera.global_position = lerp(transition_camera.global_position, to_camera.global_position, current_lerp)
	transition_camera.zoom = lerp (transition_camera.zoom, to_camera.zoom, current_lerp)

		
	if are_cameras_aligned(transition_camera, to_camera):
		to_camera.enabled = true
		to_camera.make_current()
		transitioning = false
		
func are_cameras_aligned(one : Camera2D, two : Camera2D) -> bool:
	if is_equal_approx(one.global_position.x, two.global_position.x) and is_equal_approx(one.global_position.y, two.global_position.y) and is_equal_approx(one.zoom.x, two.zoom.x) and is_equal_approx(one.zoom.y, two.zoom.y):
		return true
	return false
