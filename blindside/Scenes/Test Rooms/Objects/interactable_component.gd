extends Node2D

## Sets up the class to use as a Node
class_name Interactable

@export var parent : Node
@export var is_sadie_interactable : bool = false
@export var is_alex_interactable : bool = false
@export var interaction_area : Area2D
@export var icon_position : Vector2

@export var alex_icon : Sprite2D
@export var sadie_icon : Sprite2D

var last_id : int = 0

func _ready() -> void:
	set_icon_positions()
func interact(id : int):
	last_id = id
	if id == 1 and !is_sadie_interactable:
		return
	if id == 2 and !is_alex_interactable:
		return
	if parent.has_method("interact"):
		parent.interact()

func _physics_process(delta: float) -> void:
	alex_icon = $"Player Icon"
	sadie_icon = $"Player Icon2"
	if scan_for_players() == true:
		if is_sadie_interactable:
			sadie_icon.enable()
		if is_alex_interactable:
			alex_icon.enable()
	else:
		sadie_icon.disable()
		alex_icon.disable()

func set_icon_positions():
	if is_alex_interactable and is_sadie_interactable:
		alex_icon.position = icon_position
		sadie_icon.position = icon_position
		alex_icon.position.x -= 40
		sadie_icon.position.x += 40
	elif is_alex_interactable:
		alex_icon.position = icon_position
	elif is_sadie_interactable:
		sadie_icon.position = icon_position
		
	alex_icon.real_position = alex_icon.position
	sadie_icon.real_position = sadie_icon.position
	
func scan_for_players() -> bool:
	var areas = interaction_area.get_overlapping_areas()
	if !areas:
		return false
	for area in areas:
		if area.get_parent() is InteractionComponent:
			match(area.get_parent().player_id):
				1: return true
				2: return true
	return false
