extends CharacterBody2D

@onready var velocity_comp : VelocityComponent = $"Velocity Component"
@onready var jump_comp : JumpComponent = $"Jump Component"
@onready var gravity_comp : GravityComponent = $"Gravity Component"
@onready var direction_comp : DirectionComponent = $"Direction Component"

@export var id = 1
@export var light : PointLight2D
@export var input_left : StringName
@export var input_right : StringName
@export var input_jump : StringName

@export var max_light_scale : float = 10
@export var min_light_scale : float = 2

@onready var state_machine : StateMachine = $"Movement FSM"

var sadie : CharacterBody2D

#variable jump values
var is_jumping : bool
var variable_jump_timer : SceneTreeTimer
@export var variable_jump_window : float = 0.2

#jump buffer values
var is_jump_queued : bool = false
var jump_buffer_timer : SceneTreeTimer
@export var jump_buffer_window : float = 0.2

func _ready() -> void:
	get_sadie()
	jump_comp.jump.connect(begin_variable_jump)
	
func _physics_process(delta: float) -> void:
	if is_on_floor():
		is_jumping = false
		if is_jump_queued:
			is_jump_queued = false
			jump_comp.apply_jump_impulse()
			
	if !sadie:
		get_sadie()
		
	if sadie:
		var distance = position.distance_to(sadie.position)
		distance = clamp(distance, 1, 1000)
		distance /= 100
		var light_scale = 8 - distance
		light_scale = clamp(light_scale, min_light_scale, max_light_scale)
		light.scale = Vector2(light_scale, light_scale)
	
func get_sadie():
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player.name == "PlayerSadie":
			sadie = player
	
func buffer_jump():
	is_jump_queued = true
	jump_buffer_timer = get_tree().create_timer(jump_buffer_window)
	jump_buffer_timer.timeout.connect(end_jump_buffer)
	
func end_jump_buffer():
	is_jump_queued = false
	
func begin_variable_jump():
	is_jumping = true
	variable_jump_timer = get_tree().create_timer(variable_jump_window)
	variable_jump_timer.timeout.connect(end_variable_jump)
	
func end_variable_jump():
	if !is_on_floor():
		is_jumping = false


func _on_alex_circle_area_entered(area: Area2D) -> void:
	# When Alex and Sadie are close double the size of the light
	# Uses collision layer 3
	
	pass
	#$PointLight2D.scale = Vector2 ($PointLight2D.scale.x * 2, $PointLight2D.scale.y * 2)
	

func _on_alex_circle_area_exited(area: Area2D) -> void:
	# When Alex and Sadie are far away half the size of the light
	# Uses collision layer 3
	
	pass
	#$PointLight2D.scale = Vector2 ($PointLight2D.scale.x / 2, $PointLight2D.scale.y / 2)
	


func _on_interacting_circle_area_entered(area: Area2D) -> void:
	# When Alex is near an interactable object
	# Uses collision layer 4
	
	if area.is_in_group("Interactable"):
		area.get_node("Interactable").interactable  = true
		
	# Debug code to check functionality
	#$PointLight2D.color = Color(0.71, 0.224, 0.796, 1.0)
	

func _on_interacting_circle_area_exited(area: Area2D) -> void:
	# When Alex leaves an interactable object
	# Uses collision layer 4
	
	if area.is_in_group("Interactable"):
		area.get_node("Interactable").interactable  = false
			
	# Debug code to check functionality
	#$PointLight2D.color = Color(1.0, 1.0, 1.0, 1.0)
	
